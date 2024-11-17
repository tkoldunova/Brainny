//
//  ShopModel.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

enum CoinsModel: String, CaseIterable {
    case start = "com.start.product"
    case middle = "com.middle.product"
    case grand = "com.grand.product"
    
    var title: String {
        switch self {
        case .start:
            return NSLocalizedString("shop.coins.startPack", comment: "")
        case .middle:
            return NSLocalizedString("shop.coins.middlePack", comment: "")
        case .grand:
            return NSLocalizedString("shop.coins.grandPack", comment: "")
        }
    }
    
    var index: Int {
        return (CoinsModel.allCases.firstIndex(of: self) ?? 0)
    }
    
    var value: Int {
        switch self {
        case .start:
            return 50
        case .middle:
            return 250
        case .grand:
            return 500
        }
    }
    
    var image: UIImage {
        return UIImage(named: String(describing: self))!
    }
}


