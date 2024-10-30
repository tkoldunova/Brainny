//
//  ShopViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

class ShopViewController: BaseViewController<ShopPresenterProtocol>, ShopViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = presenter
            collectionView.dataSource = presenter
          //  collectionView.collectionViewLayout.hef
       //     collectionView.layout.headerReferenceSize = CGSize(width: view.frame.width, height: 60)
            collectionView.register(ShopCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ShopCollectionHeaderView.reuseIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyWhenViewDidLoad()
        self.navigationItem.title = NSLocalizedString("shop.title", comment: "")
        // Do any additional setup after loading the view.
    }
    func reloaData() {
        collectionView.reloadData()
    }
    

}
