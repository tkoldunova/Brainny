//
//  ShopInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

protocol ShopInteractorProtocol {
    var model: [ProductModel] {get}
    var subscription: [ProductModel] { get }
    var coins: Int {get set}
    var count: Int {get set}
    func requestProducts(completion:@escaping(Bool)->Void)
    func buy(product: ProductModel, completion:@escaping(Bool)->Void)
    func hasUnlockPro()->Bool
    func getCount() -> Int
    func update()
    func restore(completion:@escaping()->Void) 
}

final class ShopInteractor: ShopInteractorProtocol {
    var model: [ProductModel]
    var subscription: [ProductModel]
    var purchaseManager = PurchaseManager.shared
    var count: Int = 0
    var coins: Int {
        didSet {
            UserDefaultsValues.coins = coins
        }
    }
    init() {
        coins = UserDefaultsValues.coins
        self.model = [ProductModel]()
        self.subscription = [ProductModel]()
        
    }
    
    func update() {
        self.coins = UserDefaultsValues.coins
    }
    
    func getCount() -> Int {
        return count + subscription.count
    }
    
    func hasUnlockPro()->Bool {
        return purchaseManager.hasUnlockedPro
    }
    
    func requestProducts(completion:@escaping(Bool)->Void) {
        //        purchaseManager.requestProducts { products in
        //            self.model = products?.filter({$0 is CoinsProductSub}) as! [CoinsProductSub]
        //            self.model = self.model.sorted(by: {$0.model.index < $1.model.index})
        //            self.subscription = products?.filter({$0 is ProductSub}) as! [ProductSub]
        //
        //            completion()
        //        }
        purchaseManager.loadProducts { [weak self] result in
            switch result {
            case .success(let allModels):
                guard let self = self else {return}
                self.model = allModels.filter({$0.model != nil})
                self.model = self.model.sorted(by: {$0.model?.index ?? 0 < $1.model?.index ?? 0})
                self.subscription = allModels.filter({$0.model == nil})
                completion(true)
            case .failure(let failure):
                completion(false)
            }
        }
    }
    
    
    
    func buy(product: ProductModel, completion:@escaping(Bool)->Void) {
        
        
        purchaseManager.purchase(product.product) { result in
            switch result {
            case .success(let success):
                if let model = product.model {
                    UserDefaultsValues.coins += model.value
                } else {
                    
                }
                print(self.purchaseManager.hasUnlockedPro ? "Подписка есть" : "Подписки нет")
                completion(true)
            case .failure(let failure):
                completion(false)
            }
        }
    }
    
    
    func restore(completion:@escaping()->Void) {
        Task {
            await PurchaseManager.shared.updatePurchasedProducts()
            completion()
        }
        
    }
}
