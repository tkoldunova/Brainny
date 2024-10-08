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

extension ShopPresenter: ShopCellDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.model.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop", for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
        if indexPath.row < interactor.model.count {
            
            cell.configure(product: interactor.model[indexPath.row])
        } else {
            cell.configure(model: .hap)
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ShopCollectionHeaderView.reuseIdentifier, for: indexPath) as! ShopCollectionHeaderView
            headerView.label.text = "Get Coins"
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

    
    func buyProduct(product: CoinsProductSub) {
        self.interactor.buy(product: product) {
            print("buy succ \(UserDefaultsValues.coins)")
        }
    }
    
    func watchAdAndGet(model: CoinsModel) {
        return
    }
    
}

