//
//  ShopViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

class ShopViewController: BaseViewController<ShopPresenterProtocol>, ShopViewProtocol {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = presenter
            collectionView.dataSource = presenter
            collectionView.register(ShopCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShopCollectionHeaderView.reuseIdentifier)
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .vertical
            flowLayout?.minimumInteritemSpacing = 16
            flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
            
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
        presenter.notifyWhenViewDidLoad()
        self.navigationItem.title = NSLocalizedString("shop.title", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinsHStackView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.notifyWhenViewWillApear()
    }
    
    func reloaData() {
        collectionView.reloadData()
    }
    
    func setUpCoinsLabel(coins: Int) {
        coinsLabel.text = coins.description
    }
    
    func setUpEmptyLabel(hidden: Bool) {
        self.emptyLabel.isHidden = hidden
    }
    
    func startAnimating() {
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
    
}
