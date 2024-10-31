//
//  IapManager.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit
import StoreKit

//public typealias ProductsRequestCompletionHandler =
public typealias ProductPurchaseCompletionHandler = (_ success: Bool, _ productId : String?) -> Void

class IAPManager: NSObject {
    
    //MARK: -Properties
    private var productsRequestCompletionHandler: ((_ products: [any ProductSubscription]?) -> Void)?
    private var productPurchaseCompletionHandler: ProductPurchaseCompletionHandler?
    private let coinsProductsID = Set(CoinsModel.allCases.map({$0.rawValue}))
    private let noAdsProductID = Set(["com.noAds.product"])
    //MARK: -Initializer
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    //MARK: -RequestProduct
    func requestProducts(_ complition: @escaping ([any ProductSubscription]?) -> Void) {
        productsRequestCompletionHandler = complition
    //    let array = coinsProductsID + noAdsProductID
        var productsID = coinsProductsID.union(noAdsProductID)
        let request = SKProductsRequest(productIdentifiers: productsID)
        request.delegate = self
        request.start()
    }
    //MARK: -PurchaseProduct
    
    func buySubcription(_ id: SKProduct, _ complition: @escaping ProductPurchaseCompletionHandler) {
        buyProduct(id) { success, productId in
            complition(success, productId)
        }
    }
    
    func buyProduct(_ id: SKProduct, _ complition: @escaping ProductPurchaseCompletionHandler) {
        guard SKPaymentQueue.canMakePayments() else { return }
        productPurchaseCompletionHandler = complition
        let payment = SKPayment(product: id)
        SKPaymentQueue.default().add(payment)
        
    }
    func restoreTransactions(_ complition : @escaping ProductPurchaseCompletionHandler) {
        productPurchaseCompletionHandler = complition
        SKPaymentQueue.default().transactions
        if (SKPaymentQueue.canMakePayments()) {
           
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func listen() {
        
    }
}
//MARK: -SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        var poducts = [any ProductSubscription]()
        for product in response.products {
            if coinsProductsID.contains(product.productIdentifier) {
                poducts.append(CoinsProductSub(product))
            } else {
                poducts.append(ProductSub(product))
            }
        }
        productsRequestCompletionHandler?(poducts)
        clearRequestAndHandler()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKProductsRequest {
            print("Subscription Options Failed Loading: \(error.localizedDescription)")
        }
        productsRequestCompletionHandler?(nil )
        clearRequestAndHandler()
    }
    private func clearRequestAndHandler() {
        productsRequestCompletionHandler = nil
    }
    
}

extension IAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                complete(transaction: transaction)
                break
            case .failed:
                fail(transaction: transaction)
                break
            case .restored:
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        productPurchaseCompleted(productID: transaction.payment.productIdentifier, transactionId: transaction.transactionIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        print("restore... \(productIdentifier)")
        productPurchaseCompleted(productID: productIdentifier, transactionId: transaction.original?.transactionIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        if let transactionError = transaction.error as NSError?,
           let localizedDescription = transaction.error?.localizedDescription,
           transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }
        
        productPurchaseCompletionHandler?(false, nil)
        SKPaymentQueue.default().finishTransaction(transaction)
        clearHandler()
    }
     
    private func productPurchaseCompleted(productID : String, transactionId: String?) {
        productPurchaseCompletionHandler?(true, productID)
        clearHandler()
    }
    
    private func clearHandler() {
        productPurchaseCompletionHandler = nil
    }
    
}


