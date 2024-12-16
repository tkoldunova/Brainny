//
//  LoaderRouter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.12.2024.
//

import Foundation
import UIKit
protocol LoaderRouterProtocol: RouterProtocol {
    func present()
    func goToMenu()
}

final class LoaderRouter: LoaderRouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func createInstance() -> UIViewController {
        let vc = LoaderViewController.instantiateMyViewController(name: "Loader")
        let interactor = LoaderInteractor()
        let presenter = LoaderPresenter(view: vc, interactor: interactor, router: self)
        vc.presenter = presenter
        return vc
    }
    
    func present() {
        guard let navigationController = navigationController else {return}
        let vc = createInstance()
        navigationController.viewControllers = [vc]
    }
    
    func goToMenu() {
        let rootNavVC = UINavigationController()
        let router: MenuRouterProtocol = MenuRouter(navigationController: rootNavVC)
        router.present()
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = .fade
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.layer.add(transition, forKey: "fade")
            sceneDelegate.window?.rootViewController = rootNavVC
        }
    }
}
