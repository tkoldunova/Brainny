//
//  SettingsTableViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 05.10.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    var model: SettingsModel?
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: SettingsModel) {
        self.model = model
        titleLabel.text = model.title
        iconImageView.image = model.image
        switchView.isOn = model.isOn
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: Any) {
        model?.valueChanged(newValue: switchView.isOn)
    }
}
