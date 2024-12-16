//
//  LanguageViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import UIKit

class LanguageViewController: BaseViewController<LanguagePresenterProtocol>, LanguageViewProtocol {
    lazy var tapGestureRcognizer = UITapGestureRecognizer(target: self, action: #selector(hide))
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.layer.cornerRadius = 12.0
            contentView.layer.borderWidth = 2.0
            contentView.layer.borderColor = Colors.borderColor.cgColor
        }
    }
    @IBOutlet weak var chooseLabel: UILabel! {
        didSet {
            chooseLabel.text = NSLocalizedString("language.title", comment: "")
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = presenter
            tableView.dataSource = presenter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.alpha = 0.55
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
        self.view.addGestureRecognizer(tapGestureRcognizer)
        tapGestureRcognizer.delegate = self

    }
    
    func reloadData() {
        chooseLabel.text = NSLocalizedString("language.title", comment: "")
        tableView.reloadData()
    }
    
    @objc func hide() {
        AudioManager.shared.playTouchedSound()
        self.presenter.dismiss()
    }

    
}

extension LanguageViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: contentView) == true {
            return false
        }
        return true
    }
}

