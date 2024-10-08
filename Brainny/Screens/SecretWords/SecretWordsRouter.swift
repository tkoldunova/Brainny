//
//  SecretWordsRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//


import UIKit

protocol SecretWordsRouterProtocol {
    func present(model: SecretWords)
}

final class SecretWordsRouter: SecretWordsRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance(model: SecretWords) -> UIViewController {
        let vc = SecretWordsViewController.instantiateMyViewController(name: "Secret words")
        let interactor = SecretWordsInteractor(model: model)
        let presenter = SecretWordsPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present(model: SecretWords) {
        guard let navigationController = navigationController else {return}
        let vc = createInstance(model: model)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
