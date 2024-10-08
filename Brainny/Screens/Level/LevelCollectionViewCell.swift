//
//  LevelCollectionViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    func configure(title: String, available: Bool, done:Bool) {
        self.layer.cornerRadius = 24
        self.layer.borderColor = Colors.borderColor.cgColor
        self.layer.borderWidth = 3.0
        self.levelLabel.text = title
        self.questionImageView.isHidden = available
        self.levelLabel.isHidden = !available
        self.checkmarkImageView.isHidden = !done
    }
    
}
