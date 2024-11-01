//
//  GameRouter.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit



protocol AnagramsRouterProtocol: AnyObject {
    func present(model: AnagramModel)
    func dismiss()
}


class AnagramsRouter: AnagramsRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
//    static func createModule() -> AnnagramsViewController {
//        let router = AnagramsRouter()
//        let interactor = AnagramsInteractor(anangram: AnagramModel.lvl1)
//        let vc = AnnagramsViewController.instantiateMyViewController(name: "GameViewController")
//        vc.presenter = AnagramsPresenter(view: vc, router: router, interactor: interactor)
//        return vc
//    }
    
    func createInstance(model: AnagramModel) -> UIViewController {
        let vc = AnnagramsViewController.instantiateMyViewController(name: "AnnagramsViewController")
        let interactor = AnagramsInteractor(anangram: model)
        let presenter = AnagramsPresenter(view: vc, router: self, interactor: interactor)
        vc.presenter = presenter
        return vc
    }
    
    func present(model: AnagramModel) {
        guard let navigationController = navigationController else {return}
        let vc = createInstance(model: model)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
        
}
