//
//  SettingsRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 05.10.2024.
//

import UIKit

protocol SettingsRouterProtocol: RouterProtocol {
    func present()
    func dismiss()
}

final class SettingsRouter: SettingsRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance() -> UIViewController {
        let vc = SettingsViewController.instantiateMyViewController(name: "Settings")
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present() {
        guard let navigationController = navigationController else {return}
        let vc = createInstance()
   //     navigationController.viewControllers = [vc]
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
    
   
    
}

