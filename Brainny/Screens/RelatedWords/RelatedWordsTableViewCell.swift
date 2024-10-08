//
//  RelatedWordsTableViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 25.09.2024.
//

import UIKit

class RelatedWordsTableViewCell: UITableViewCell {
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionMarkStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: RelatedWordModel) {
        frameView.layer.cornerRadius = 12.0
        frameView.layer.borderColor = Colors.borderColor.cgColor
        frameView.layer.borderWidth = 2.0
        self.titleLabel.text = model.answer
        questionMarkStackView.isHidden = model.guessed
        self.titleLabel.isHidden = !model.guessed
    }
    
    func guessed(model: RelatedWordModel) {
        titleLabel.text = model.answer
        if model.guessed {
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.frameView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0, animations: {
                    self.frameView.transform = CGAffineTransform.identity
                })
            })
            self.titleLabel.alpha = 0
            self.titleLabel.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.titleLabel.alpha = 1
                self.questionMarkStackView.alpha = 0
            }) { res in
                self.questionMarkStackView.isHidden = true
                self.questionMarkStackView.alpha = 1
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
