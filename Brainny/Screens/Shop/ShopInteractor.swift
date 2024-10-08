//
//  ShopInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

protocol ShopInteractorProtocol {
    var model: [CoinsProductSub] {get}
    var coins: Int {get set}
    func requestProducts(completion:@escaping()->Void)
    func buy(product: CoinsProductSub, completion:@escaping()->Void)
}

final class ShopInteractor: ShopInteractorProtocol {
    var model: [CoinsProductSub]
    var purchaseManager = IAPManager()

    var coins: Int {
        didSet {
            UserDefaultsValues.coins = coins
        }
    }
    init() {
        coins = UserDefaultsValues.coins
        self.model = [CoinsProductSub]()
    }
    
    func requestProducts(completion:@escaping()->Void) {
        purchaseManager.requestProducts { products in
            self.model = products ?? [CoinsProductSub]()
            completion()
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
