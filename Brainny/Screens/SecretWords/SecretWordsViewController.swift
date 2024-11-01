//
//  SecretWordViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//

import UIKit

class SecretWordsViewController: BaseViewController<SecretWordsPresenterProtocol>, SecretWordsViewProtocol {
    lazy var winView = WinView(frame: self.view.bounds)
    lazy var tipView = TipView(frame: self.view.bounds)
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.tintColor = Colors.borderColor
        button.addTarget(self, action: #selector(sendbuttonTouched(_:)), for: .touchUpInside)
        return button
    }()
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = NSLocalizedString("secretWord.subtitle", comment: "")
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = presenter
            tableView.dataSource = presenter
        }
    }
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.cornerRadius = 12.0
            textField.layer.masksToBounds = true
            textField.layer.borderWidth = 2.0
            textField.layer.borderColor = Colors.borderColor.cgColor
            textField.delegate = presenter
            textField.rightView = sendButton
            textField.rightViewMode = .whileEditing
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var answerView: UIView! {
        didSet {
            answerView.layer.cornerRadius = 12.0
            answerView.layer.borderColor = Colors.borderColor.cgColor
            answerView.layer.borderWidth = 2.0
        }
    }
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.notifyWhenViewDidLoad()
        self.title = NSLocalizedString("secretWord.title", comment: "")
    }
    
    func shakeTextField() {
        self.textField.shake(repeated: false)
    }
    
    func setAnswerView(answer: RelatedWordModel) {
        self.answerLabel.text = answer.answer
        answerStackView.isHidden = answer.guessed
        self.answerLabel.isHidden = !answer.guessed
    }
    
    func setAnswerQuessed(answer: RelatedWordModel) {
        answerLabel.text = answer.answer
        if answer.guessed {
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.answerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0, animations: {
                    self.answerView.transform = CGAffineTransform.identity
                })
            })
            self.answerLabel.alpha = 0
            self.answerLabel.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.answerLabel.alpha = 1
                self.answerStackView.alpha = 0
            }) { res in
                self.answerStackView.isHidden = true
                self.answerStackView.alpha = 1
            }
        }
    }
    
    func showTipView(type: TipType) {
        tipView = TipView(frame: self.view.bounds)
        tipView.configure(type: type)
        tipView.alpha = 0
        tipView.center = self.view.center
        tipView.delegate = presenter
        self.view.addSubview(tipView)
        UIView.animate(withDuration: 0.75) {
            self.tipView.alpha = 1
        }
    }
    
    func hideTipView() {
        UIView.animate(withDuration: 0.5) {
            self.tipView.alpha = 0
        } completion: { _ in
            self.tipView.removeFromSuperview()
        }
    }
    
    func showWinView() {
        winView.configure()
        winView.alpha = 0
        winView.center = self.view.center
        winView.delegate = presenter
        self.view.addSubview(winView)
        UIView.animate(withDuration: 0.75) {
            self.winView.alpha = 1
        }
    }
    
    func reloadWordsData() {
        self.tableView.reloadData()
    }
    
    
    @objc func sendbuttonTouched(_ sender: Any) {
        presenter.checkValue()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            // Get the location of the touch in the main view's coordinate system
            let touchLocation = touch.location(in: self.view)
            if answerView.frame.contains(touchLocation) {
                AudioManager.shared.playTouchedSound()
//                UIView.animate(withDuration: 0.5, animations: {
//
//                })
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first {
            // Get the location of the touch in the main view's coordinate system
            let touchLocation = touch.location(in: self.view)
            if answerView.frame.contains(touchLocation) {
                self.presenter.openTipForAnswer()
            }
        }
        
    }
    
    
}
