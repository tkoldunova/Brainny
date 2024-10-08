//
//  BaseViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

class MainViewController:UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
      // setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        self.title = ""
        
        guard let navigationController = self.navigationController else {return}
        
        let navBar = navigationController.navigationBar
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundImage = nil
        standardAppearance.backgroundColor = .clear
        standardAppearance.shadowColor = .clear
        standardAppearance.shadowImage = UIImage()
             standardAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "LuckiestGuy-Regular", size: 24)!,
        ]
        standardAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "LuckiestGuy-Regular", size: 24)!,
        ]
        let backImage = UIImage(named: "arrowLeft")!
        standardAppearance.setBackIndicatorImage(backImage.withRenderingMode(.alwaysOriginal), transitionMaskImage: backImage.withRenderingMode(.alwaysOriginal))

        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navBar.compactAppearance = standardAppearance
        navBar.compactScrollEdgeAppearance = standardAppearance
        if #available(iOS 15.0, *) {
            navBar.compactScrollEdgeAppearance = standardAppearance
        }
        navigationController.navigationBar.tintColor = UIColor.white
    }
   
    
    
}


protocol BasePresenterProtocol: AnyObject {}


class BaseViewController<T>: MainViewController {
    var presenter: T!
    
    
    func setUpGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor(red: 116/255, green: 70/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 70/255, green: 42/255, blue: 153/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.name = "gradien layer"
        gradient.masksToBounds = true
        gradient.cornerRadius = self.view.layer.cornerRadius
        self.view.layer.insertSublayer(gradient, at: 0)
    }
}
