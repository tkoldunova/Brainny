//
//  ProductSub.swift
//  Brainny
//
//  Created by Tanya Koldunova on 08.10.2024.
//
import UIKit
import StoreKit

public struct ProductSub: Hashable {
    let title: String
    var price: String?
    let locale: Locale
    let product: SKProduct
    
    
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
        self.price = formatter.string(from: product.price)
       
    }
    
    
}
