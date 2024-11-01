//
//  ShopPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import Foundation
import UIKit
protocol ShopViewProtocol: AnyObject {
    func reloaData()
}

protocol ShopPresenterProtocol: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    init(view: ShopViewProtocol, interactor: ShopInteractorProtocol, router: ShopRouterProtocol)
    func notifyWhenViewDidLoad()
}

final class ShopPresenter: NSObject, ShopPresenterProtocol {
    
    
    weak var view: ShopViewProtocol?
    var interactor: ShopInteractorProtocol
    var router: ShopRouterProtocol
    
    required init(view: ShopViewProtocol, interactor: ShopInteractorProtocol, router: ShopRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewDidLoad() {
        self.interactor.requestProducts {
            DispatchQueue.main.async {
                self.view?.reloaData()

            }
        }
    }
    
    
}

extension ShopPresenter: ShopCellDelegate, NoAdsDelegate {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? interactor.model.count + 1 : interactor.subscription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop", for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
            if indexPath.row < interactor.model.count {
                
                cell.configure(product: interactor.model[indexPath.row])
            } else {
                cell.configure(model: .hap)
            }
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "no ads", for: indexPath) as? NoAdsCollectionViewCell else {return UICollectionViewCell()}
            let data = interactor.subscription[indexPath.row]
            cell.delegate = self
            cell.configure(model: data)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ShopCollectionHeaderView.reuseIdentifier, for: indexPath) as! ShopCollectionHeaderView
            headerView.label.text = NSLocalizedString("shop.coins.title", comment: "")
      //      headerView.label.text = indexPath.section == 0 ? "Get Coins" : "Subscription"
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: 60)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)  // Adjust the top value for spacing
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: 349, height: 80)
        } else {
            return CGSize(width: 180, height: 255)
        }
    }

    
    func buyProduct(product: CoinsProductSub) {
        self.interactor.buy(product: product) {
            print("buy succ \(UserDefaultsValues.coins)")
        }
    }
    
    func watchAdAndGet(model: CoinsModel) {
        return
    }
    
    func buyButtonPressed(_ cell: NoAdsCollectionViewCell) {
        guard let product = cell.model else { return }
        interactor.buySubscription(product: product)
    }
    
}

