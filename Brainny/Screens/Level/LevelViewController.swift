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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("level.title", comment: "")
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }

}
