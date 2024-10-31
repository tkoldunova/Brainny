//
//  ShopInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

protocol ShopInteractorProtocol {
    var model: [CoinsProductSub] {get}
    var subscription: [ProductSub] { get }
    var coins: Int {get set}
    func requestProducts(completion:@escaping()->Void)
    func buy(product: CoinsProductSub, completion:@escaping()->Void)
    func buySubscription(product: ProductSub)
}

final class ShopInteractor: ShopInteractorProtocol {
    var model: [CoinsProductSub]
    var subscription: [ProductSub]
    var purchaseManager = IAPManager()

    var coins: Int {
        didSet {
            UserDefaultsValues.coins = coins
        }
    }
    init() {
        coins = UserDefaultsValues.coins
        self.model = [CoinsProductSub]()
        self.subscription = [ProductSub]()
        
    }
    
    func requestProducts(completion:@escaping()->Void) {
        purchaseManager.requestProducts { products in
            self.model = products?.filter({$0 is CoinsProductSub}) as! [CoinsProductSub]
            self.subscription = products?.filter({$0 is ProductSub}) as! [ProductSub]
            completion()
        }
    }
    
    func buySubscription(product: ProductSub) {
        purchaseManager.buySubcription(product.product) { success, productId in
            
        }
    }
    
    func buy(product: CoinsProductSub, completion:@escaping()->Void) {
        purchaseManager.buyProduct(product.product) { success, productId in
            if success {
                UserDefaultsValues.coins += self.model.count
                completion()
            }
        }
    }
}
