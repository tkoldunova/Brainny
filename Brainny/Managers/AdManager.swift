//
//  AdManager.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.11.2024.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency

class InterstitialAdManager: NSObject, GADFullScreenContentDelegate {
    private var interstitial: GADInterstitialAd?
    var interstitialCompletion: ((_ sucess: Bool)->Void)?
    weak var parentVC: UIViewController?
    var testUnit = "ca-app-pub-3940256099942544/4411468910"
    var unitId = "ca-app-pub-9561374795177219/4143257192"
    init(parentVC:UIViewController?) {
        self.parentVC = parentVC
    }
    
    func requestTracking() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                DispatchQueue.main.async {
                    self.prepare()
                }
            }
        }else{
            self.prepare()
        }
    }
    
    
    func prepare(completion: (()->Void)? = nil) {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:unitId ,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
            completion?()
        }
        )
    }
    
    func show(completion: @escaping(Bool)->Void) {
        self.interstitialCompletion = completion
        if let interstitial = interstitial {
            interstitial.fullScreenContentDelegate = self
            interstitial.present(fromRootViewController: parentVC)
            prepare()
            interstitialCompletion = completion
        } else {
            completion(false)
            prepare()
        }
        
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.interstitialCompletion?(false)
        
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.interstitialCompletion?(true)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        prepare()
    }
}

class RewardAdManager: NSObject, GADFullScreenContentDelegate {
    private var rewardedAd: GADRewardedInterstitialAd?
    var rewardedAdCompletion: ((_ sucess: Bool)->Void)?
    var testUnit = "ca-app-pub-3940256099942544/6978759866"
    var unitId = "ca-app-pub-9561374795177219/3951685505" //UserDefaultsValues.rewardedId
    weak var parentVC: UIViewController?
    init(parentVC:UIViewController?) {
        self.parentVC = parentVC
    }
    
    func prepare(completion: ((GADRewardedInterstitialAd?)->Void)? = nil) {
        GADRewardedInterstitialAd.load(withAdUnitID: unitId,
                                       request: GADRequest()) { ad, error in
            if let error = error {
                completion?(nil)
                return print("Failed to load rewarded interstitial ad with error: \(error.localizedDescription)")
            }
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
            completion?(self.rewardedAd)
        }
        
    }
    
    func show(completion: @escaping(Bool)->Void) {
        self.rewardedAdCompletion = completion
      //  guard let parentVC = parentVC else {return}
        guard let rewardedAd = rewardedAd else {completion(false);return}
        rewardedAd.present(fromRootViewController: parentVC) {
            UserDefaultsValues.coins += Int(rewardedAd.adReward.amount)
            completion(true)
            self.prepare()
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.rewardedAdCompletion?(false)
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        // self.rewardedAdCompletion?(true)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        prepare()
    }
}
