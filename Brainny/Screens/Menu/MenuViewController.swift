//
//  MenuViewViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

class MenuViewController: BaseViewController<MenuPresenterProtocol>, MenuViewProtocol {
    @IBOutlet weak var staticQuestionImageView: UIImageView!
    @IBOutlet var dynamicQuestionImageViews: [UIImageView]!
    
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
        let scaleXAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        scaleXAnimation.fromValue = 1
        scaleXAnimation.toValue = -1
        scaleXAnimation.duration = 1.0
        scaleXAnimation.repeatCount = .infinity
        scaleXAnimation.autoreverses = true
        dynamicQuestionImageViews.forEach { imgView in
            imgView.layer.add(scaleXAnimation, forKey: "scaleXAnimation")
        }
      
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
        self.presenter.goToSettings()
    }
    @IBAction func shopButtonTouched(_ sender: Any) {
        self.presenter.goToShop()
        
    }
}

extension MenuViewController: BubleViewDelegate {
    func touched(_ view: BubleView) {
        if let ind = bubleViews.firstIndex(of: view) {
            presenter.goToLevel()
        }
    }
}
