//
//  ShopCollectionViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

protocol ShopCellDelegate {
    func buyProduct(product: CoinsProductSub)
    func watchAdAndGet(model: CoinsModel)
}

class ShopCollectionViewCell: UICollectionViewCell {
    var delegate: ShopCellDelegate?
    var product: CoinsProductSub?
    var model: CoinsModel?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var coinsImageView: UIImageView!
    @IBOutlet weak var priceButton: UIButton! {
        didSet {
            priceButton.layer.cornerRadius = 12.0
            priceButton.layer.borderWidth = 2.0
            priceButton.layer.borderColor = Colors.borderColor.cgColor
        }
    }
    @IBOutlet weak var adsImageView: UIImageView!
    
    
    func configure(product: CoinsProductSub) {
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = Colors.borderColor.cgColor
       
        setUpRadialGradient()
        self.product = product
        self.model = nil
        self.titleLabel.text = product.model.title
        self.valueLabel.text = product.model.value.description
        self.coinsImageView.image = product.model.image
        self.priceButton.setTitle(product.price, for: .normal)
        self.adsImageView.isHidden = true
    }
    
    
    func configure(model: CoinsModel) {
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = Colors.borderColor.cgColor
        setUpRadialGradient()
        self.model = model
        self.product = nil
        self.titleLabel.text = model.title
        self.valueLabel.text = model.value.description
        self.coinsImageView.image = model.image
        self.priceButton.setTitle("Watch ad", for: .normal)
        self.adsImageView.isHidden = false
    }
    
    func setUpRadialGradient(){
        let gradLayer = CAGradientLayer()
        gradLayer.frame = self.layer.bounds
        gradLayer.type = .radial
        gradLayer.colors = [ UIColor(red: 144/255, green: 123/255, blue: 209/255, alpha: 1).cgColor,
                             UIColor(red: 82/255, green: 47/255, blue: 190/255, alpha: 1).cgColor]
        gradLayer.locations = [ 0, 1 ]
        gradLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradLayer.endPoint = CGPoint(x: 1, y: 1)
        gradLayer.cornerRadius = self.layer.cornerRadius
        layer.insertSublayer(gradLayer, at: 0)
    }
    
    @IBAction func priceButtonTouched(_ sender: Any) {
        if let product = product {
            AudioManager.shared.playTouchedSound()
            self.delegate?.buyProduct(product: product)
        } else if let model = model {
            AudioManager.shared.playTouchedSound()
            self.delegate?.watchAdAndGet(model: model)
        }
    }
}
