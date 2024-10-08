//
//  VolumeTableViewCell.swift
//  Brainny
//
//  Created by Tanya Koldunova on 05.10.2024.
//

import UIKit

class VolumeTableViewCell: UITableViewCell {
    var model: VolumeModel?
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sliderView: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: VolumeModel) {
        self.model = model
        titleLabel.text = model.title
        iconImageView.image = model.image
        self.sliderView.value = model.value
        
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        if let model = model {
            model.valueChanged(volume: sliderView.value)
        }

    }
}
