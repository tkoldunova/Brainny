//
//  MenuRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//


import UIKit

protocol MenuRouterProtocol {
    func present()
    func goToLevel(game: Games)
    func goToSettings()
    func goToShop()
    func goToLanguage(delegate: LanguageDelegate)
}

final class MenuRouter: MenuRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance() -> UIViewController {
        let vc = MenuViewController.instantiateMyViewController(name: "Menu")
        let interactor = MenuInteractor()
        let presenter = MenuPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present() {
        guard let navigationController = navigationController else {return}
        let vc = createInstance()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToLevel(game: Games) {
      
            guard let navigationController = navigationController else {return}
            let vc = LevelRouter(navigationController: navigationController)
            vc.present(model: game)
            return
     
    }
    
    func goToSettings() {
            guard let navigationController = navigationController else {return}
            let vc = SettingsRouter(navigationController: navigationController)
            vc.present()
            return
     
    }
    
    func goToLanguage(delegate: LanguageDelegate) {
            guard let navigationController = navigationController else {return}
        let vc = LanguageRouter(navigationController: navigationController)
        vc.present(delegate: delegate)
            return
     
    }
    
    func goToShop() {
            guard let navigationController = navigationController else {return}
            let vc = ShopRouter(navigationController: navigationController)
            vc.present()
            return
     
    }
    
//    func goToAnagrams() {
//        guard let navigationController = navigationController else {return}
//        let vc = GameRouter.
//    }
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
