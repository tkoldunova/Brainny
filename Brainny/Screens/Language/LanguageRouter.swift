//
//  LanguageRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import UIKit

protocol LanguageRouterProtocol: RouterProtocol {
    func present(delegate: LanguageDelegate?)
    func dismiss()
}

final class LanguageRouter: LanguageRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance(delegate: LanguageDelegate?) -> UIViewController {
        let vc = LanguageViewController.instantiateMyViewController(name: "Language")
        let interactor = LanguageInteractor(delegate: delegate)
        let presenter = LanguagePresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present(delegate: LanguageDelegate?) {
        guard let navigationController = navigationController else {return}
        let vc = createInstance(delegate: delegate)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
    }
    
    func dismiss() {
        self.navigationController?.dismiss(animated: true)
    }
    
   
    
}

