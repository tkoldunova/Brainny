//
//  MenuViewViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

class MenuViewController: BaseViewController<MenuPresenterProtocol>, MenuViewProtocol {
    @IBOutlet weak var staticQuestionImageView: UIImageView!
    @IBOutlet var dynamicQuestionImageViews: [UIImageView]! {
        didSet {
            //dynamicQuestionImageViews[1].transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var shopButton: UIButton! {
        didSet {
            shopButton.applyShadow()
        }
    }
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            settingsButton.applyShadow()
        }
    }
    var bubleViews: [BubleView] = [BubleView]()
    //  lazy var bubleView = BubleView(frame: CGRect(x: 50, y: 50, width: 280, height: 110))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpGradient()
        presenter.notifyWhenViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        dynamicQuestionImageViews.forEach { imgView in
            var rotationAndPerspectiveTransform = CATransform3DIdentity
            rotationAndPerspectiveTransform.m34 = -1.0 / 1000.0
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? Double.pi * 1 : -Double.pi, 0, 1, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? 0.1 : -0.1)
            var rotationAndPerspectiveTransform2 = CATransform3DIdentity
            rotationAndPerspectiveTransform2.m34 = 1.0 / 1000.0
            rotationAndPerspectiveTransform2 = CATransform3DRotate(rotationAndPerspectiveTransform, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? -Double.pi * 1 : Double.pi, 0, 1, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? -0.1 : 0.1)
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse]) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                    imgView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    imgView.layer.transform = rotationAndPerspectiveTransform
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                    imgView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    imgView.layer.transform = rotationAndPerspectiveTransform2
                })
            }
//            UIView.animate(withDuration: 1.0, delay: 0, options: ,  animations: {
//                imgView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//                imgView.layer.transform = rotationAndPerspectiveTransform
//            }, completion: { finished in
//            })
        }
       
      
//        dynamicQuestionImageViews.forEach { imgView in
//            let scaleXAnimation = CABasicAnimation(keyPath: "transform.scale.x")
//            scaleXAnimation.fromValue = (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? -1 : 1
//            scaleXAnimation.toValue = (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? 1 : -1
//            scaleXAnimation.duration = 1.0
//            scaleXAnimation.repeatCount = .infinity
//            scaleXAnimation.autoreverses = true
//            imgView.layer.add(scaleXAnimation, forKey: "scaleXAnimation")
//        }
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bubleViews.forEach { view in
            view.animation()
        }
    }
    
    
    func configureBubleView(model: [Games]) {
        for m in model {
            let bubleView = BubleView()
            bubleView.titleLabel.text = m.title
            bubleView.game = m
            bubleView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bubleView.widthAnchor.constraint(equalToConstant: 300),
                bubleView.heightAnchor.constraint(equalToConstant: 110)
            ])
            bubleView.delegate = self
            
            buttonStackView.addArrangedSubview(bubleView)
            bubleViews.append(bubleView)
            
        }
    }
    
    @IBAction func settingsButtonTouched(_ sender: Any) {
        AudioManager.shared.playTouchedSound()
        self.presenter.goToSettings()
    }
    @IBAction func shopButtonTouched(_ sender: Any) {
        AudioManager.shared.playTouchedSound()
        self.presenter.goToShop()
        
    }
}

extension MenuViewController: BubleViewDelegate {
    func touched(_ view: BubleView) {
        if let game = view.game {
            AudioManager.shared.playTouchedSound()
            presenter.goToLevel(game: game)
        }
  
    }
}
