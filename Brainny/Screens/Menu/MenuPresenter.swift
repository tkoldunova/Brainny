//
//  MenuPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//
import UIKit

protocol MenuViewProtocol: AnyObject {
    func configureBubleView(model: [Games])
   
}

protocol MenuPresenterProtocol: AnyObject {
    init(view: MenuViewProtocol, interactor: MenyInteractorProtocol, router: MenuRouterProtocol)
    func notifyWhenViewDidLoad()
    func goToLevel()
    func goToSettings()
    func goToShop() 
}

final class MenuPresenter: NSObject, MenuPresenterProtocol {
    
    weak var view: MenuViewProtocol?
    var interactor: MenyInteractorProtocol
    var router: MenuRouterProtocol
    
    required init(view: MenuViewProtocol, interactor: MenyInteractorProtocol, router: MenuRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewDidLoad() {
        self.view?.configureBubleView(model: interactor.model)
    }
    
    func goToLevel() {
        self.router.goToLevel()
    }
    
    func goToSettings() {
        self.router.goToSettings()
    }
    
    func goToShop() {
        self.router.goToShop()
    }
 
}

