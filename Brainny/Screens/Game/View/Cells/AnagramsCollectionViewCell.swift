//
//  AnagramsCollectionViewCell.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import SpriteKit

class AnagramsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionsImageView: UIImageView!
    @IBOutlet weak var worldLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 16
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor(red: 28/255, green: 201/255, blue: 159/255, alpha: 1).cgColor
        }
    }
    
    
    func configure(_ str: String, isAvailable: Bool) {
        worldLabel.text = str
        
        worldLabel.isHidden = !isAvailable
        questionsImageView.isHidden = isAvailable
        
    }
    
    
}
