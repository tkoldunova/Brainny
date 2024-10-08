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
            return "Hap of coins"
        case .bundles:
            return "Coin Bundles"
        case .vault:
            return "Coin Vault"
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


