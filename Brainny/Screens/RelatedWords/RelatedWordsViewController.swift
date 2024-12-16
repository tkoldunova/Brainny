//
//  RelatedWordsViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

class RelatedWordsViewController: BaseViewController<RelatedWordsPresenterProtocol>, RelatedWordsViewProtocol {
    lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.tintColor = Colors.borderColor
        button.addTarget(self, action: #selector(sendbuttonTouched(_:)), for: .touchUpInside)
        return button
    }()
    lazy var tipView = TipView(frame: self.view.bounds)
    lazy var winView = WinView(frame: self.view.bounds)
   
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text =  NSLocalizedString("relatedWords.subtitle", comment: "")
        }
    }
    @IBOutlet weak var wordsCollectionView: UICollectionView! {
        didSet {
            wordsCollectionView.delegate = presenter
            wordsCollectionView.dataSource = presenter
            let flowLayout = wordsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .vertical
            flowLayout?.minimumInteritemSpacing = 16
            flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            flowLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var wordsTableView: UITableView! {
        didSet {
            wordsTableView.delegate = presenter
            wordsTableView.dataSource = presenter
        }
    }
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.cornerRadius = 12.0
            textField.layer.masksToBounds = true
            textField.layer.borderWidth = 2.0
            textField.layer.borderColor = Colors.borderColor.cgColor
            textField.placeholder = NSLocalizedString("relatedWords.placeholder", comment: "")
            textField.delegate = presenter
            textField.rightView = sendButton
            textField.rightViewMode = .whileEditing
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  NSLocalizedString("relatedWords.title", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinsHStackView)
        presenter.notifyWhenViewDidLoad()
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self

    }
    
    func setUpCoinsLabel(coins: Int) {
        coinsLabel.text = coins.description
    }
    
    func setTextFieldEmpty() {
        self.textField.text = nil
    }
    
    func shakeTextField() {
        self.textField.shake(repeated: false)
    }
    
    func getCell(indexPath: IndexPath) -> UITableViewCell? {
        let cell = wordsTableView.cellForRow(at: indexPath)
        return cell
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
    
    func reloadWordsData() {
        self.wordsCollectionView.reloadData()
    }
    
    func showAlert() {
        NotificationManager.showMesssage(theme: .error, title: NSLocalizedString("messages.coins.title", comment: ""), message:  NSLocalizedString("messages.coins.subtitle", comment: ""), actionText: "", duration: .automatic, action: nil)
    }
    
    

    @objc func sendbuttonTouched(_ sender: Any) {
        presenter.checkValue()
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}

extension RelatedWordsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: wordsCollectionView) == true {
            return false
        }
        if touch.view?.isDescendant(of: wordsTableView) == true {
            return false
        }
        return true
    }
}



