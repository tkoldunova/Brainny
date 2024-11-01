//
//  TipView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 25.09.2024.
//

import UIKit

struct TipWordModel {
    var title: String
    var price: Int
    var word: String
}

struct TipLetterModel {
    var tip: [String?]
    var answer: String
    var price: Int
    
    mutating func changeTip(str: String, ind: Int) {
        self.tip[ind] = str
    }
}

enum TipType {
    case word(TipWordModel)
    case letter(TipLetterModel)
    
    var isWord: Bool {
        switch self {
        case .word:
            return true
        case .letter:
            return false
        }
    }
    
    var title: String {
        switch self {
        case .word(let tipWordModel):
            return tipWordModel.title
        case .letter(let tipLetterModel):
            return "Unlcok letter"
        }
    }
    
    var price: Int {
        switch self {
        case .word(let tipWordModel):
            return tipWordModel.price
        case .letter(let tipLetterModel):
            return tipLetterModel.price
        }
    }
}

protocol TipViewDelegate {
    func tipHasChanged(_ tip: [String?], answer: String)
    func unlockWord(word: String)
    
    func openWord(answer: String)
}

class TipView: UIView {
    var type: TipType?
    var contentView: UIView?
    var letterView = [LetterView]()
    var delegate: TipViewDelegate?
    lazy var tapGestureRcognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
    @IBOutlet weak var frameView: UIView! {
        didSet {
            frameView.layer.cornerRadius = 12
            frameView.layer.borderWidth = 3
            frameView.layer.borderColor = Colors.borderColor.cgColor
            
        }
    }
    @IBOutlet weak var unlockTipStackView: UIStackView!
    @IBOutlet weak var unlockTipLabel: UILabel! {
        didSet {
            unlockTipLabel.text = NSLocalizedString("tip.word.title", comment: "")
        }
    }
    @IBOutlet weak var unlockTipPriceLabel: UILabel!
    @IBOutlet weak var unlockTipPriceButton: UIButton! {
        didSet {
            unlockTipPriceButton.setTitle(NSLocalizedString("tip.word.button", comment: ""), for: .normal)
            unlockTipPriceButton.layer.cornerRadius = 12
            unlockTipPriceButton.layer.borderWidth = 3
            unlockTipPriceButton.layer.borderColor = Colors.borderColor.cgColor
            
        }
    }
    @IBOutlet weak var unlockWordsStackView: UIStackView!
    
    @IBOutlet weak var unlockWordLabel: UILabel! {
        didSet {
            unlockWordLabel.text = NSLocalizedString("tip.letter.title", comment: "")
        }
    }
    @IBOutlet weak var unlockWordPriceButton: UIButton! {
        didSet {
            unlockWordPriceButton.layer.cornerRadius = 12
            unlockWordPriceButton.layer.borderWidth = 3
            unlockWordPriceButton.layer.borderColor = Colors.borderColor.cgColor
            
        }
    }
    @IBOutlet weak var letterStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        self.addGestureRecognizer(tapGestureRcognizer)
        tapGestureRcognizer.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
        self.addGestureRecognizer(tapGestureRcognizer)
        tapGestureRcognizer.delegate = self
    }
    
    
    private func configureView() {
        guard let view = self.loadFromNib(nib: TipView.self) else {return}
        view.frame = bounds
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
    
    
    func configure(type: TipType) {
        self.type = type
        self.unlockTipStackView.isHidden = !type.isWord
        self.unlockWordsStackView.isHidden = type.isWord
        self.unlockTipLabel.text = type.title
        self.unlockWordLabel.text = type.title
        self.unlockTipPriceLabel.text = type.price.description
        self.unlockWordPriceButton.setTitle(type.price.description, for: .normal)
        switch type {
        case .word(let tipWordModel):
            return
        case .letter(let tipLetterModel):
            clearLetterStack()
            letterStackView.isHidden = false
            let empty = tipLetterModel.tip.allSatisfy({$0 == nil})
            for i in 0 ..< tipLetterModel.tip.count {
                
                let letterView = LetterView(letter: tipLetterModel.tip[i])
                letterView.translatesAutoresizingMaskIntoConstraints = false
                if empty && i > 2 {
                    letterView.isHidden = true
                }
                NSLayoutConstraint.activate([
                    letterView.widthAnchor.constraint(equalToConstant: 35),
                    letterView.heightAnchor.constraint(equalToConstant: 35)
                ])
                letterStackView.addArrangedSubview(letterView)
                self.letterView.append(letterView)
            }
            
            
        }
    }
    
    func clearLetterStack() {
        for subview in letterStackView.arrangedSubviews {
            letterStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func configureLetterViews(tip: [String?]) {
        let empty = tip.allSatisfy({$0 == nil})
        for i in 0 ..< tip.count {
            UIView.animate(withDuration: 0.5) {
                self.letterView[i].isHidden = (empty && i > 2) ? true : false
            }
            self.letterView[i].letter = tip[i]
        }
    }
    
    func hideTipView() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    @objc func hide() {
        AudioManager.shared.playTouchedSound()
        self.hideTipView()
    }
    
    @IBAction func unlockButtonTouched(_ sender: Any) {
        if let type = type {
            AudioManager.shared.playTouchedSound()
            switch type {
            case .word(let tipWordModel):
                self.delegate?.unlockWord(word: tipWordModel.word)
                hideTipView()
            case .letter(let tipLetterModel):
                
                var tip = tipLetterModel.tip
                if tip.contains(nil) {
                    var charInserted = false
                    while !charInserted {
                        let randomIndex = Int.random(in: 0..<tipLetterModel.answer.count)
                        let char = String(tipLetterModel.answer[tipLetterModel.answer.index(tipLetterModel.answer.startIndex, offsetBy: randomIndex)])
                        if tipLetterModel.tip[randomIndex] == nil {
                           // tipLetterModel.changeTip(str: char, ind: randomIndex)
                            tip[randomIndex] = char
                            charInserted = true
                        }
                    }
                    configureLetterViews(tip: tip)
                    delegate?.tipHasChanged(tip, answer: tipLetterModel.answer)
                    self.type = TipType.letter(TipLetterModel(tip: tip, answer: tipLetterModel.answer, price: tipLetterModel.price))
                    if !tip.contains(nil) {
                        delegate?.openWord(answer: tipLetterModel.answer)
                        hideTipView()
                    }

                } else {
                    delegate?.openWord(answer: tipLetterModel.answer)
                    hideTipView()
                }
            }
        }
        
    }
    
    
    
}

extension TipView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: frameView) == true {
            return false
        }
        return true
    }
}


