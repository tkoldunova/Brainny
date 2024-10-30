//
//  GameRouter.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit



protocol GameRouterProtocol: AnyObject {
    
}


class GameRouter: GameRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> GameViewController {
        let router = GameRouter()
        let interactor = GameInteractor(anangram: AnagramModel.lvl1)
        let vc = GameViewController.instantiateMyViewController(name: "GameViewController")
        vc.presenter = GamePresenter(view: vc, router: router, interactor: interactor)
        return vc
    }
    
    
    
    
        
}
