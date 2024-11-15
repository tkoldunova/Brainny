//
//  ShopHeaderView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 07.10.2024.
//
import UIKit

class ShopCollectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "shop header"
    
    lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "ribbon"))
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.applyShadow()
        return imgView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
    }
    
    
    func configureSubviews() {
        self.addSubview(bgImageView)
        bgImageView.fillSuperview()
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4),
        ])
    }
    
}
