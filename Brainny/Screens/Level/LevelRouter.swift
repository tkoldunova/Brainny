//
//  LevelRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//

import UIKit

protocol LevelRouterProtocol {
    func present(model: Games)
    func goToRelatedWords(model: RelatedWords)
    func goToSecretWords(model: SecretWords)
}

final class LevelRouter: LevelRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance(model: Games) -> UIViewController {
        let vc = LevelViewController.instantiateMyViewController(name: "Level")
        let interactor = LevelInteractor(model: model)
        let presenter = LevelPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present(model: Games) {
        guard let navigationController = navigationController else {return}
        let vc = createInstance(model: model)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToRelatedWords(model: RelatedWords) {
        let vc = RelatedWordsRouter(navigationController: navigationController)
        vc.present(model: model)
    }
    
    func goToSecretWords(model: SecretWords) {
        let vc = SecretWordsRouter(navigationController: navigationController)
        vc.present(model: model)
    }
    
    
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

