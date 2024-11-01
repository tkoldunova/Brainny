//
//  AnagramsCollectionViewCell.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import SpriteKit

class AnagramsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionStackView: UIStackView!
    @IBOutlet weak var worldLabel: UILabel!
    @IBOutlet var questionImageViews: [UIImageView]!
    //    @IBOutlet weak var containerView: UIView! {
//        didSet {
//            containerView.layer.cornerRadius = 16
//            containerView.layer.borderWidth = 2
//            containerView.layer.borderColor = UIColor(red: 28/255, green: 201/255, blue: 159/255, alpha: 1).cgColor
//        }
//    }
    
    
    func configure(model: RelatedWordModel) {
        self.layer.cornerRadius = 12.0
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.borderWidth = 2.0
        worldLabel.text = model.answer
        questionStackView.isHidden = model.guessed
        questionImageViews.forEach { imgView in
            imgView.isHidden = model.guessed
        }
        worldLabel.isHidden = !model.guessed
        
    }
    
    
}
