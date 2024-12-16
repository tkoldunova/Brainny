//
//  LoaderPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.12.2024.
//

import Foundation
import UIKit

protocol LoaderViewProtocol: AnyObject {
    func playAnimation(duration: TimeInterval)
    func playAnimations()
}

protocol LoaderPresenterProtocol: ProgressDelegate {
    init(view: LoaderViewProtocol, interactor: LoaderInteractorProtocol, router: LoaderRouterProtocol)
    func notifyWhenViewWillApear()
}

class LoaderPresenter: NSObject, LoaderPresenterProtocol {
    weak var view: LoaderViewProtocol?
    var router: LoaderRouterProtocol
    var interactor: LoaderInteractorProtocol
    
    required init(view: LoaderViewProtocol, interactor: LoaderInteractorProtocol, router: LoaderRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewWillApear() {
        self.view?.playAnimation(duration: interactor.animationDration)
        self.view?.playAnimations()
        
    }
    
    func end() {
        self.router.goToMenu()
    }
   

}

