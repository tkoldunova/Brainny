//
//  GameViewController.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit
import SpriteKit
import GameplayKit

class AnnagramsViewController: BaseViewController<AnagramsPresenterProtocol> {
    lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    lazy var winView = WinView(frame: self.view.bounds)
    lazy var tipView = TipView(frame: self.view.bounds)
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = NSLocalizedString("anagrams.subtitle", comment: "")
        }
    }
    @IBOutlet weak var gameView: SKView! {
        didSet {
            
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = presenter
            collectionView.dataSource = presenter
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .vertical
            flowLayout?.minimumInteritemSpacing = 16
            flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            flowLayout?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var timerLabel: UILabel!
    
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
        
        //        self.setUpNavigationController()
        
        self.title = NSLocalizedString("anagrams.title", comment: "")
        
        
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.size = gameView.bounds.size
            if let scene = scene as? GameScene {
                scene.gameSceneDelegate = self
                scene.world = presenter.getWold()
            }
            // Present the scene
            gameView.presentScene(scene)
        }
        
        gameView.ignoresSiblingOrder = true
        
        // gameView.showsFPS = true
        gameView.backgroundColor = .clear
        //gameView.showsNodeCount = true
        // gameView.isHidden = true
        self.presenter.notifyWhenViewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinsHStackView)
        self.view.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.delegate = self
    }
    
    func setUpCoinsLabel(coins: Int) {
        coinsLabel.text = coins.description
    }
    
    func showWinView() {
        winView.configure(showDescription: true)
        winView.alpha = 0
        winView.center = self.view.center
        winView.delegate = presenter
        self.view.addSubview(winView)
        UIView.animate(withDuration: 0.75) {
            self.winView.alpha = 1
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
    
    func setUpPointsLabel(count: Int, maxCount: Int) {
        self.timerLabel.text = count.description + "/" + maxCount.description
    }
    
    func showAlert() {
        NotificationManager.showMesssage(theme: .error, title: NSLocalizedString("messages.coins.title", comment: ""), message:  NSLocalizedString("messages.coins.subtitle", comment: ""), actionText: "", duration: .automatic, action: nil)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
}

extension AnnagramsViewController: AnagramsView {
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates(nil, completion: nil)
        }
    }
    
    
}


extension AnnagramsViewController: GameSceneDelegate {
    func checkIfWordIsCorrect(world: String) -> Bool {
        presenter.checkIfWorldIsCorrect(word: world)
    }
    
    func getSubtitlePos() -> CGPoint {
        return subtitleLabel.center
    }
    
    
}

extension AnnagramsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: collectionView) == true {
            return false
        }
        return true
    }
}

