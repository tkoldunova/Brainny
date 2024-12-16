//
//  LanguagePresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import Foundation
import UIKit

protocol LanguageViewProtocol: AnyObject {
    func reloadData()
}

protocol LanguagePresenterProtocol: UITableViewDelegate, UITableViewDataSource {
    init(view: LanguageViewProtocol, interactor: LanguageInteractorProtocol, router: LanguageRouterProtocol)
    func notifyWhenViewDidLoad()
    func dismiss()
}

class LanguagePresenter: NSObject, LanguagePresenterProtocol {
    weak var view: LanguageViewProtocol?
    var router: LanguageRouterProtocol
    var interactor: LanguageInteractorProtocol
    
    required init(view: LanguageViewProtocol, interactor: LanguageInteractorProtocol, router: LanguageRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewDidLoad() {
    }
    
    func dismiss() {
        if interactor.oldValue != interactor.currentLanguage {
            self.interactor.delegate?.changedLanguage(language: interactor.currentLanguage)
        }
        self.router.dismiss()
    }
    
}

extension LanguagePresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "language", for: indexPath) as? LanguageTableViewCell else {return UITableViewCell()}
        cell.configure(model: interactor.model[indexPath.row], isSelected: interactor.currentLanguage == interactor.model[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.currentLanguage = interactor.model[indexPath.row]
        Bundle.setLanguage(interactor.currentLanguage.rawValue)
        self.view?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}


