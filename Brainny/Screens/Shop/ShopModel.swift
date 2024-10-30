//
//  ShopModel.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

enum CoinsModel: String, CaseIterable {
    case hap = "com.hap.product"
    case bundles = "com.bundles.product"
    case vault = "com.vault.product"
    
    var title: String {
        switch self {
        case .hap:
            return NSLocalizedString("shop.coins.hap", comment: "")
        case .bundles:
            return NSLocalizedString("shop.coins.bundles", comment: "")
        case .vault:
            return NSLocalizedString("shop.coins.vault", comment: "")
        }
    }
    
    var value: Int {
        switch self {
        case .hap:
            return 50
        case .bundles:
            return 150
        case .vault:
            return 500
        }
    }
    
    var image: UIImage {
        return UIImage(named: String(describing: self))!
    }
}


