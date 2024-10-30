//
//  LevelPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//

import UIKit
protocol LevelViewProtocol: AnyObject {
func reloadData()
}

protocol LevelPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource {
    init(view: LevelViewProtocol, interactor: LevelInteractorProtocol, router: LevelRouterProtocol)
}

final class LevelPresenter: NSObject, LevelPresenterProtocol {
    
    weak var view: LevelViewProtocol?
    var interactor: LevelInteractorProtocol
    var router: LevelRouterProtocol
    
    required init(view: LevelViewProtocol, interactor: LevelInteractorProtocol, router: LevelRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
   
}

extension LevelPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.model.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "level", for: indexPath) as? LevelCollectionViewCell else {return UICollectionViewCell()}
        let m = interactor.model.model[indexPath.row]
        cell.configure(title: (m.index+1).description, available: interactor.model.availableLevels.contains(where: {$0.areEqual(to: m)}), done: interactor.model.doneLevels.contains(where: {$0.areEqual(to: m)}))
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let m = interactor.model.model[indexPath.row]
        if interactor.model.availableLevels.contains(where: {$0.areEqual(to: m)}) {
            if let m = m as? RelatedWords {
                self.router.goToRelatedWords(model: m)
            } else if let m = m as? SecretWords {
                self.router.goToSecretWords(model: m)
            }
        }

    }
    
}

