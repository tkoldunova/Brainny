//
//  GameViewController.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: BaseViewController<GamePresenterProtocol> {

    @IBOutlet weak var subtitleLabel: UILabel!
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
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setUpNavigationController()
        
        self.title = "Annagrams"
        
        
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
        
        gameView.showsFPS = true
        gameView.showsNodeCount = true
       
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GameView {
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}


extension GameViewController: GameSceneDelegate {
    func checkIfWordIsCorrect(world: String) -> Bool {
        presenter.checkIfWorldIsCorrect(word: world)
    }
    
    func getSubtitlePos() -> CGPoint {
        return subtitleLabel.center
    }
    
    
}
