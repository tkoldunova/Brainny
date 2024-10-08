//
//  LevelRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//

import UIKit

protocol LevelRouterProtocol {
    func present(model: Games)
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
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

