//
//  UIViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 24.09.2024.
//

import UIKit

extension UIViewController {

    static func instantiateMyViewController(name: String) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! Self
        return vc
    }
    
    
}
