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
            
        }
    }
 //   @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
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
    
}

extension AnnagramsViewController: AnagramsView {
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
