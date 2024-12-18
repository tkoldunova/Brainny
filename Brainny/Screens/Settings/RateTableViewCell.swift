//
//  RateTableViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 18.12.2024.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    var model: DetailSettingsModel?
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(model: DetailSettingsModel) {
        self.model = model
        titleLabel.text = model.title
        iconImageView.image = model.image        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
