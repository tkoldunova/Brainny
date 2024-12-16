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
    func setUpCoinsLabel(coins: Int)
    func setUpEmptyLabel(hidden: Bool)
    func startAnimating() 
    func stopAnimating()
}

protocol ShopPresenterProtocol: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    init(view: ShopViewProtocol, interactor: ShopInteractorProtocol, router: ShopRouterProtocol)
    func notifyWhenViewDidLoad()
    func notifyWhenViewWillApear()
}

final class ShopPresenter: NSObject, ShopPresenterProtocol {
    weak var view: ShopViewProtocol?
    var interactor: ShopInteractorProtocol
    var router: ShopRouterProtocol
    lazy var adManager = RewardAdManager(parentVC: nil)
    
    required init(view: ShopViewProtocol, interactor: ShopInteractorProtocol, router: ShopRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewDidLoad() {
        self.view?.setUpEmptyLabel(hidden: true)
        self.view?.startAnimating()
        self.interactor.requestProducts { _ in
            DispatchQueue.main.async {
                if let rewardedAd = self.adManager.rewardedAd {
                    self.interactor.count = self.interactor.model.count + 1
                } else {
                    self.interactor.count = self.interactor.model.count
                }
                self.view?.reloaData()
                self.view?.setUpEmptyLabel(hidden: self.interactor.getCount() > 0)
                self.view?.stopAnimating()
            }
        }
        self.view?.setUpCoinsLabel(coins: interactor.coins)
    }
    
    func notifyWhenViewWillApear() {
        self.adManager.prepare { rewardedAd in
            if let rewardedAd = rewardedAd {
                self.interactor.count = self.interactor.model.count + 1
            } else {
                self.interactor.count = self.interactor.model.count
            }
            DispatchQueue.main.async {
                self.view?.setUpEmptyLabel(hidden:  self.interactor.getCount() > 0)
                self.view?.reloaData()
            }
        }
    }
    
    
}

extension ShopPresenter: ShopCellDelegate, NoAdsDelegate {
    
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return interactor.subscription.isEmpty ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? interactor.count : interactor.subscription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shop", for: indexPath) as? ShopCollectionViewCell else {return UICollectionViewCell()}
            if indexPath.row < interactor.model.count {
                
                cell.configure(product: interactor.model[indexPath.row])
            } else {
                cell.configure(model: .start)
            }
            cell.delegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "no ads", for: indexPath) as? NoAdsCollectionViewCell else {return UICollectionViewCell()}
            let data = interactor.subscription[indexPath.row]
            cell.delegate = self
            cell.configure(model: data, purchased: interactor.hasUnlockPro())
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ShopCollectionHeaderView.reuseIdentifier, for: indexPath) as! ShopCollectionHeaderView
            headerView.label.text =  indexPath.section == 0 ?  NSLocalizedString("shop.coins.title", comment: "") : NSLocalizedString("shop.subscription.title", comment: "")
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
            return CGSize(width: collectionView.frame.width*0.86, height: 86)
        } else {
            return CGSize(width: 180, height: 255)
        }
    }

    
    func buyProduct(product: ProductModel) {
        self.interactor.buy(product: product) { succ in
            DispatchQueue.main.async {
                if succ {
                    print("buy succ \(UserDefaultsValues.coins)")
                    self.interactor.update()
                    self.view?.setUpCoinsLabel(coins: self.interactor.coins)
                    NotificationManager.showMesssage(theme: .success, title: NSLocalizedString("messages.success.payment", comment: ""), message: "", actionText: "", duration: .automatic, action: nil)
                } else {
                    NotificationManager.showMesssage(theme: .error, title: NSLocalizedString("messages.error.payment", comment: ""), message: NSLocalizedString("messages.error.payment.subtitle", comment: ""), actionText: "", duration: .automatic, action: nil)
                }
                self.view?.reloaData()

            }
        }
    }
    
    func watchAdAndGet(model: CoinsModel) {
        adManager.show { res in
        
            if let res = res {
                self.interactor.update()
                DispatchQueue.main.async {
                    self.view?.setUpCoinsLabel(coins: self.interactor.coins)
                    NotificationManager.showMesssage(theme: .success, title: NSLocalizedString("messages.success.ad.title", comment: ""), message: NSLocalizedString("messages.success.ad.subtitle", comment: "") + res.description, actionText: "", duration: .automatic, action: nil)
                }
            } else {
                DispatchQueue.main.async {
                    
                    NotificationManager.showMesssage(theme: .error, title: NSLocalizedString("messages.error.title", comment: ""), message: NSLocalizedString("messages.error.subtitle", comment: ""), actionText: "", duration: .automatic, action: nil)
                }
            }
        }
    }
    
    func buyButtonPressed(_ cell: NoAdsCollectionViewCell) {
        guard let product = cell.model else { return }
        buyProduct(product: product)
        
    }
    
    func restoreButtonPressed(_ cell: NoAdsCollectionViewCell) {
        self.interactor.restore {
            DispatchQueue.main.async {
                self.view?.reloaData()
                NotificationManager.showMesssage(theme: .info, title: NSLocalizedString("messages.info.restore", comment: ""), message: "", actionText: "", duration: .automatic, action: nil)

            }
           
        }

    }
    
}

