//
//  MenuPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//
import UIKit

protocol MenuViewProtocol: AnyObject {
    func configureBubleView(model: [Games])
    func reloadApp()
}

protocol MenuPresenterProtocol: AnyObject {
    init(view: MenuViewProtocol, interactor: MenyInteractorProtocol, router: MenuRouterProtocol)
    func notifyWhenViewDidLoad()
    func goToLevel(game: Games)
    func goToSettings()
    func goToShop()
    func goToLanguage()
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
    
    func goToLevel(game: Games) {
        self.router.goToLevel(game: game)
    }
    
    func goToSettings() {
        self.router.goToSettings()
    }
    
    func goToShop() {
        self.router.goToShop()
    }
    
    func goToLanguage() {
        self.router.goToLanguage(delegate: self)
    }
 
}

extension MenuPresenter: LanguageDelegate {
    func changedLanguage(language: Language) {
        self.view?.reloadApp()
    }
}


