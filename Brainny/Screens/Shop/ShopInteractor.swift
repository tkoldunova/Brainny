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
    var count: Int {get set}
    func requestProducts(completion:@escaping()->Void)
    func buy(product: CoinsProductSub, completion:@escaping()->Void)
    func buySubscription(product: ProductSub)
    func update()
}

final class ShopInteractor: ShopInteractorProtocol {
    var model: [CoinsProductSub]
    var subscription: [ProductSub]
    var purchaseManager = IAPManager()
    var count: Int = 0
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
    
    func update() {
        self.coins = UserDefaultsValues.coins
    }
    
    func requestProducts(completion:@escaping()->Void) {
        purchaseManager.requestProducts { products in
            self.model = products?.filter({$0 is CoinsProductSub}) as! [CoinsProductSub]
            self.model = self.model.sorted(by: {$0.model.index < $1.model.index})
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
                UserDefaultsValues.coins += product.model.value
                completion()
            }
        }
    }
}
