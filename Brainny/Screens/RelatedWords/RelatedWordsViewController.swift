//
//  RelatedWordsViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

class RelatedWordsViewController: BaseViewController<RelatedWordsPresenterProtocol>, RelatedWordsViewProtocol {
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        button.tintColor = Colors.borderColor
        button.addTarget(self, action: #selector(sendbuttonTouched(_:)), for: .touchUpInside)
        return button
    }()
    lazy var tipView = TipView(frame: self.view.bounds)
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text =  NSLocalizedString("relatedWords.subtitle", comment: "")
        }
    }
    @IBOutlet weak var wordsCollectionView: UICollectionView! {
        didSet {
            wordsCollectionView.delegate = presenter
            wordsCollectionView.dataSource = presenter
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
            textField.delegate = presenter
            textField.rightView = sendButton
            textField.rightViewMode = .whileEditing
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  NSLocalizedString("relatedWords.title", comment: "")
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
    
    func reloadWordsData() {
        self.wordsCollectionView.reloadData()
    }
    

    @objc func sendbuttonTouched(_ sender: Any) {
        presenter.checkValue()
        
    }

}
