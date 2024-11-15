//
//  LetterView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 26.09.2024.
//

import UIKit

class LetterView: UIView {
    var letter: String {
        didSet {
            nameLabel.text = letter 
            UIView.animate(withDuration: 0.5, animations: {
                self.nameLabel.alpha = self.letter == "" ? 0 : 1
                self.questionMarkImageView.alpha = self.letter != "" ? 0 : 1
            })

        }
    }
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 24)
        label.textColor = .white
        label.text = letter
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var questionMarkImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "questionMark"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    init(letter: String) {
        self.letter = letter
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 60)))
        configureSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        letter = ""
        super.init(coder: coder)
        configureSubviews()
    }
    
    func configureSubviews() {
        self.addSubview(nameLabel)
        self.addSubview(questionMarkImageView)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            questionMarkImageView.widthAnchor.constraint(equalToConstant: 24),
            questionMarkImageView.heightAnchor.constraint(equalToConstant: 24),
            questionMarkImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            questionMarkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        nameLabel.alpha = letter == "" ? 0 : 1
        questionMarkImageView.alpha = letter != "" ? 0 : 1
    }

}
