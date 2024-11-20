//
//  LevelPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//

import UIKit
protocol LevelViewProtocol: AnyObject {
func reloadData()
    func setUpCoinsLabel(coins: Int)
}

protocol LevelPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource {
    init(view: LevelViewProtocol, interactor: LevelInteractorProtocol, router: LevelRouterProtocol)
    func notifyWhenViewWillApear()
}

final class LevelPresenter: NSObject, LevelPresenterProtocol {
    
    weak var view: LevelViewProtocol?
    var interactor: LevelInteractorProtocol
    var router: LevelRouterProtocol
    var adManager = InterstitialAdManager(parentVC: nil)
    
    required init(view: LevelViewProtocol, interactor: LevelInteractorProtocol, router: LevelRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewWillApear() {
        self.view?.setUpCoinsLabel(coins: UserDefaultsValues.coins)
        self.adManager.prepare()
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
            if UserDefaultsValues.touchCount%3 == 0 {
                self.adManager.show { res in
                    guard res else {return}
                }
            }
            UserDefaultsValues.touchCount += 1
            AudioManager.shared.playTouchedSound()
            if let m = m as? RelatedWords {
                self.router.goToRelatedWords(model: m)
            } else if let m = m as? SecretWords {
                self.router.goToSecretWords(model: m)
            } else if let m = m as? AnagramModel {
                self.router.goToAnagrams(model: m)
            }
        }
    }
    
}

