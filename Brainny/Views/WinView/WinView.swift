//
//  WinView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 31.10.2024.
//

import UIKit

protocol WinViewDelegate {
    func hideWinView()
}

class WinView: UIView {
    var contentView: UIView?
    var delegate: WinViewDelegate?
    private var timer = Timer()
    var coins: Int = 0 {
        didSet {
            UIView.transition(with: coinsLabel, duration: 0.3, animations: { [weak self] in
                guard let self = self else {return}
                self.coinsLabel.text = "+" + self.coins.description
            })
        }
    }
    lazy var tapGestureRcognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
    @IBOutlet weak var frameView: UIView! {
        didSet {
            frameView.layer.cornerRadius = 12
            frameView.layer.borderWidth = 3
            frameView.layer.borderColor = Colors.borderColor.cgColor
        }
    }
    @IBOutlet weak var titlelLabel: UILabel! {
        didSet {
            titlelLabel.text =  NSLocalizedString("win.title", comment: "")
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = NSLocalizedString("win.description", comment: "")
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text =  NSLocalizedString("win.subtitle", comment: "")
        }
    }
    
    @IBOutlet weak var coinsLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        self.addGestureRecognizer(tapGestureRcognizer)
       // tapGestureRcognizer.delegate = self

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
        self.addGestureRecognizer(tapGestureRcognizer)
     //   tapGestureRcognizer.delegate = self

    }

    private func configureView() {
        guard let view = self.loadFromNib(nib: WinView.self) else {return}
        view.frame = bounds
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.masksToBounds = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.55
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurEffectView, at: 0)
        self.contentView = view
    }
    
    func configure(showDescription: Bool = false) {
        AudioManager.shared.playWinSound()
        self.descriptionLabel.isHidden = !showDescription
        self.coins = 0
        UserDefaultsValues.coins += 25
        animateCoins(totalCoins: 25)
    }

    
    func animateCoins(totalCoins: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.coins >= totalCoins {
                timer.invalidate()
            } else {
                self.coins += 1
            }
        }
    }
    
    @objc func hide() {
        delegate?.hideWinView()
    }
    
   
    
}
