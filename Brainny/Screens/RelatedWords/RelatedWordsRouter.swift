//
//  RelatedWordsRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

protocol RelatedWordsRouterProtocol {
    func present(model: RelatedWords) 
}

final class RelatedWordsRouter: RelatedWordsRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance(model: RelatedWords) -> UIViewController {
        let vc = RelatedWordsViewController.instantiateMyViewController(name: "Related Words")
        let interactor = RelatedWordsInteractor(model: model)
        let presenter = RelatedWordsPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present(model: RelatedWords) {
        guard let navigationController = navigationController else {return}
        let vc = createInstance(model: model)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
