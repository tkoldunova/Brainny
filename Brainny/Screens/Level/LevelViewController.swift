//
//  LevelViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//

import UIKit

class LevelViewController: BaseViewController<LevelPresenterProtocol>, LevelViewProtocol {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = presenter
            collectionView.dataSource = presenter
        }
    }
    
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
        self.presenter.notifyWhenViewDidLoad()
        self.title = NSLocalizedString("level.title", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinsHStackView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.notifyWhenViewWillApear()
        reloadData()
    }
    
    func setUpCoinsLabel(coins: Int) {
        coinsLabel.text = coins.description
    }
    
    
    func reloadData() {
        self.collectionView.reloadData()
    }

}
