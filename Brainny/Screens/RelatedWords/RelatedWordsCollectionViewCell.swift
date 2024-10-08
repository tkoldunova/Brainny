//
//  RelatedWordsCollectionViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 24.09.2024.
//

import UIKit

class RelatedWordsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionStackView: UIStackView!
    @IBOutlet var questionMarkImageView: [UIImageView]!
    
    
    func configure(model: WordsModel) {
        self.layer.cornerRadius = 12.0
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.borderWidth = 2.0
        titleLabel.text = model.title
        questionStackView.isHidden = !model.locked
        questionMarkImageView.forEach { imgView in
            imgView.isHidden = !model.locked
        }
        titleLabel.isHidden = model.locked
    }
    
    
}
