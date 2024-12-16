//
//  LanguageTableViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    @IBOutlet weak var countryLabek: UILabel!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: Language, isSelected: Bool) {
        self.countryLabek.text = FlagUtils.getflagByName(country: model.abbr) + " " + model.language
        self.checkmarkButton.isHidden = !isSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
