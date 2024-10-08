//
//  SecretWordTableViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//

import UIKit

class SecretWordTableViewCell: UITableViewCell {
    @IBOutlet weak var frameView: UIView! {
        didSet {
            frameView.layer.cornerRadius = 12.0
            frameView.layer.borderColor = Colors.borderColor.cgColor
            frameView.layer.borderWidth = 2.0
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionMarkStackView: UIStackView!
    
    @IBOutlet var questionMarkView: [UIImageView]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: WordsModel) {
      
        titleLabel.text = model.locked ? "" : model.title
        questionMarkStackView.isHidden = !model.locked
        questionMarkView.forEach { imgView in
            imgView.isHidden = !model.locked
        }
        titleLabel.isHidden = model.locked
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
