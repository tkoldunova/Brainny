//
//  ProducrSub.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit
import StoreKit

public struct CoinsProductSub: Hashable {
    let title: String
    var price: String?
    let locale: Locale
    let product: SKProduct
    let model: CoinsModel
    
    
    lazy var formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = locale
        return nf
    }()
    
    
    init(_ product: SKProduct) {
        self.product = product
        self.title = product.localizedTitle
        self.locale = product.priceLocale
        self.model = CoinsModel(rawValue: product.productIdentifier) ?? .hap
        self.price = formatter.string(from: product.price)
       
    }
    
    
}
