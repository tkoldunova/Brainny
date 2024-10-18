//
//  NoAdsCollectionViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 08.10.2024.
//

import UIKit

protocol NoAdsDelegate: AnyObject {
    func buyButtonPressed(_ cell: NoAdsCollectionViewCell)
}

class NoAdsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: ProductSub?
    weak var delegate: NoAdsDelegate?
    
    func configure(model: ProductSub) {
        //        titleLabel.text = "no ads"
        self.model = model
        self.layer.cornerRadius = 12.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = Colors.borderColor.cgColor
        
        
        buyButton.setTitle("Buy \(model.price ?? "")", for: .normal)
        setUpRadialGradient()
        
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
    
    @IBAction func buyButtonTouched(_ sender: Any) {
        delegate?.buyButtonPressed(self)
    }
}
