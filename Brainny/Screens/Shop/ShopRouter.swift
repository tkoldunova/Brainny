//
//  ShopRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//
import UIKit

protocol ShopRouterProtocol {
    func present()
}

final class ShopRouter: ShopRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance() -> UIViewController {
        let vc = ShopViewController.instantiateMyViewController(name: "Shop")
        let interactor = ShopInteractor()
        let presenter = ShopPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present() {
        guard let navigationController = navigationController else {return}
        let vc = createInstance()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
