//
//  SettingsPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 05.10.2024.
//


import UIKit

protocol SettingsViewProtocol: AnyObject {
    func reloadData()
}

protocol SettingsPresenterProtocol: UITableViewDelegate, UITableViewDataSource {
    init(view: SettingsViewProtocol, interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol)
    func notifyWhenViewDidLoad()
    func dismiss()
}

class SettingsPresenter: NSObject, SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var router: SettingsRouterProtocol
    var interactor: SettingsInteractorProtocol
    
    required init(view: SettingsViewProtocol, interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewDidLoad() {
    }
    
    func dismiss() {
        self.router.dismiss()
    }

}

extension SettingsPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < interactor.volumeModel.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "volume", for: indexPath) as? VolumeTableViewCell else {return UITableViewCell()}
            cell.configure(model: interactor.volumeModel[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }  else if indexPath.row < interactor.volumeModel.count + interactor.swichableModel.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as? SettingsTableViewCell else {return UITableViewCell()}
            cell.configure(model: interactor.swichableModel[indexPath.row - interactor.volumeModel.count])
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "rate", for: indexPath) as? RateTableViewCell else {return UITableViewCell()}
            cell.configure(model: interactor.detailModel[indexPath.row - interactor.volumeModel.count - interactor.swichableModel.count])
            cell.selectionStyle = .none
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RateTableViewCell, let model = cell.model {
            model.action()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
}


