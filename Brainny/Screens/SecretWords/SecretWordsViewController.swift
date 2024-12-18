//
//  SecretWordViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//

import UIKit

class SecretWordsViewController: BaseViewController<SecretWordsPresenterProtocol>, SecretWordsViewProtocol {
    lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

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
    lazy var coinsHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .trailing
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let imgView = UIImageView(image: UIImage(named: "coin"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgView.widthAnchor.constraint(equalToConstant: 20),
            imgView.heightAnchor.constraint(equalToConstant: 20)
        ])
        stackView.addArrangedSubview(coinsLabel)
        stackView.addArrangedSubview(imgView)
       
        return stackView
    }()
    
    
    lazy var coinsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 20)
        label.textColor = .white
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
            textField.placeholder = NSLocalizedString("secretWord.placeholder", comment: "")
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinsHStackView)
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self

    }
    
    func setUpCoinsLabel(coins: Int) {
        coinsLabel.text = coins.description
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
        hideKeyboard()
        tipView = TipView(frame: self.view.bounds)
        tipView.configure(type: type)
        tipView.alpha = 0
        tipView.center = self.view.center
        tipView.delegate = presenter
        if tipView.superview == nil {
            self.view.addSubview(tipView)
        }
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
        hideKeyboard()
        winView.configure()
        winView.alpha = 0
        winView.center = self.view.center
        winView.delegate = presenter
        if winView.superview == nil {
            self.view.addSubview(winView)
        }
        UIView.animate(withDuration: 0.75) {
            self.winView.alpha = 1
        }
    }
    
    func showAlert() {
        NotificationManager.showMesssage(theme: .error, title: NSLocalizedString("messages.coins.title", comment: ""), message:  NSLocalizedString("messages.coins.subtitle", comment: ""), actionText: "", duration: .automatic, action: nil)
    }
    
    
    func reloadWordsData() {
        self.tableView.reloadData()
    }
    
    func setTextFieldEmpty() {
        self.textField.text = nil
    }
    
    
    @objc func sendbuttonTouched(_ sender: Any) {
        presenter.checkValue()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            // Get the location of the touch in the main view's coordinate system
            let touchLocation = touch.location(in: self.view)
            if answerView.frame.contains(touchLocation) && tipView.superview == nil && winView.superview == nil {
                AudioManager.shared.playTouchedSound()
                self.presenter.openTipForAnswer()
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
            }
        }
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
}

extension SecretWordsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tableView) == true {
            return false
        }
        return true
    }
}


