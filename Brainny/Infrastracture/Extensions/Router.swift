//
//  Router.swift
//  Brainny
//
//  Created by Tanya Koldunova on 24.09.2024.
//

import UIKit
protocol RouterProtocol {
    func createInstance() -> UIViewController
    
}

extension RouterProtocol {
    func createInstance() -> UIViewController {return UIViewController()}
}
