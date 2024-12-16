//
//  PurchaseManager.swift
//  Brainny
//
//  Created by Tanya Koldunova on 29.11.2024.
//

import Foundation
import StoreKit

public struct ProductModel {
    var model: CoinsModel?
    let product: Product
        
    init(_ product: Product) {
        self.product = product
        self.model = CoinsModel(rawValue: product.id)
    }
}


class PurchaseManager {
    static let shared = PurchaseManager()
    
    private let productIds: [String]
    private(set) var products: [Product] = []
    private(set) var purchasedProductIDs = Set<String>()
    
    private var productsLoaded = false
    private var updates: Task<Void, Never>? = nil
    
    private init() {
        var strIds = CoinsModel.allCases.map({$0.rawValue})
        strIds.append("com.noAds.product")
        self.productIds = strIds
        self.updates = observeTransactionUpdates()
    }
    
    deinit {
        self.updates?.cancel()
    }
    
    // Check if Pro features are unlocked
    var hasUnlockedPro: Bool {
        return !self.purchasedProductIDs.isEmpty
    }
    
    // Load products with a completion handler
    func loadProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        Task {
            do {
                guard !self.productsLoaded else {
                    let productModel = self.products.compactMap({ProductModel($0)})
                    completion(.success(productModel))
                    return
                }
                self.products = try await Product.products(for: productIds)
                self.productsLoaded = true
                let productModel = self.products.compactMap({ProductModel($0)})
                completion(.success(productModel))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // Purchase a product with a completion handler
    func purchase(_ product: Product, completion: @escaping (Result<Void, Error>) -> Void) {
        Task {
            do {
                let result = try await product.purchase()
                switch result {
                case let .success(.verified(transaction)):
                    await transaction.finish()
                    await self.updatePurchasedProducts()
                    completion(.success(()))
                case let .success(.unverified(_, error)):
                    completion(.failure(error))
                case .pending:
                    completion(.failure(NSError(domain: "PurchaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Transaction pending approval."])))
                case .userCancelled:
                    completion(.failure(NSError(domain: "PurchaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Purchase cancelled by user."])))
                @unknown default:
                    completion(.failure(NSError(domain: "PurchaseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred."])))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func restorePurchases(completion: @escaping (Result<Void, Error>) -> Void) {
            Task {
                do {
                    // Fetch all current entitlements (active purchases)
                    for await result in Transaction.currentEntitlements {
                        if case .verified(let transaction) = result {
                            if transaction.revocationDate == nil {
                                self.purchasedProductIDs.insert(transaction.productID)
                            }
                        }
                    }
                    completion(.success(())) // Successfully restored purchases
                } catch {
                    completion(.failure(error)) // Handle errors during restoration
                }
            }
        }
    
    // Update purchased products with a completion handler
    func updatePurchasedProducts() async {
        purchasedProductIDs.removeAll()
           for await result in Transaction.currentEntitlements {
               print (result)
               guard case .verified(let transaction) = result else {
                   continue
               }
               
               if transaction.revocationDate == nil {
                   self.purchasedProductIDs.insert(transaction.productID)
               } else {
                   self.purchasedProductIDs.remove(transaction.productID)
               }
           }
       }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await verificationResult in Transaction.updates {
                            switch verificationResult {
                            case .verified(let transaction):
                                await transaction.finish()
                                await self.updatePurchasedProducts()
                            case .unverified(_, _):
                                break
                            }
                        }        }
    }
}
