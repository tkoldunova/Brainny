//
//  GameScene.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import SpriteKit
import GameplayKit


protocol GameSceneDelegate: AnyObject {
    func getSubtitlePos() -> CGPoint
    
    func checkIfWordIsCorrect(world: String) -> Bool
}

class GameScene: SKScene {
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    var world: String!
    
    lazy var enterButton : EnterButton = {
        let enterButton = EnterButton()
        enterButton.zPosition = 7
        enterButton.delegate = self
        return enterButton
    }()
 
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        spawbEmptyNode()
        spawnCharNodes()
        
       
        
        let charNode = childNode(withName: "word_node") as! WorldNode
        
        enterButton.position.y = charNode.position.y - charNode.size.height/2 - enterButton.size.height/2 - 32
        addChild(enterButton)
    }
    
    
    func spawbEmptyNode() {
        let count = world.count
        
        let width: CGFloat = (45 * CGFloat(count - 1)) + (8 * CGFloat(count - 1))
        
        
        
        
        for i in 0 ... count - 1 {
            let emptyNode = EmptyNode()
            let startY: CGFloat
            if let neededPoint = gameSceneDelegate?.getSubtitlePos() {
                if let convertedPos = view?.convert(neededPoint, to: self) {
                    startY = convertedPos.y - 85
                } else {
                    startY = size.height/3.5
                }
            } else {
                startY = size.height/3.5
            }
            emptyNode.position = CGPoint(x: -width/2 + (emptyNode.size.width + 8) * CGFloat(i), y: startY)
            
            addChild(emptyNode)
            
        }
    }
    
    
    
    func spawnCharNodes() {
        let emptyNode = childNode(withName: "empty_node") as! EmptyNode
        let shuffledWorld = world.shuffled()
        self.world = String(shuffledWorld)
        let count = world.count
        let width: CGFloat = (45 * CGFloat(count - 1)) + (8 * CGFloat(count - 1))
        
        for i in 0 ... count - 1 {
            let world = shuffledWorld[i]
            let worldNode = WorldNode()
            worldNode.position = CGPoint(x: -width/2 + (emptyNode.size.width + 8) * CGFloat(i), y: emptyNode.position.y - worldNode.size.width - 12)
            worldNode.delegate = self
            worldNode.char = String(world)
            addChild(worldNode)
        }
        
        
    }
    
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


extension GameScene: WorldNodeDelegate, EnterButtonDelegate {
    func touched(_ node: EnterButton) {
        let worldNodes = children.filter({$0.name == "empty_node"}) as! [EmptyNode]
        
        let emptyWorldNodes = worldNodes.filter({!$0.isEmpty})
        guard emptyWorldNodes.count > 2 else { enterButton.shake(duration: 0.7) {}; return}
        
        var world = [String]()
        
        for emptyWorldNode in emptyWorldNodes {
            world.append(emptyWorldNode.worldNode!.char!)
            let node = emptyWorldNode.worldNode!
            node.moveTo(node.lastPos!, duaration: 0.25) {
                node.lastPos = nil
            }
            
            emptyWorldNode.worldNode = nil
            
        }
        
        let newWorld = world.joined()
        
        print(newWorld)
        
        if let correct = gameSceneDelegate?.checkIfWordIsCorrect(world: newWorld) {
            if correct {
                
            } else {
                enterButton.shake(duration: 0.7) {
                    
                }
            }
        }
        
    }
    
    
    
    func touched(_ node: WorldNode) {
        let worldNodes = children.filter({$0.name == "empty_node"}) as! [EmptyNode]
        
        let emptyWorldNodes = worldNodes.filter({$0.isEmpty})
        
        
        if let lastPos = node.lastPos {
            
            
            for i  in 0 ... worldNodes.count - 1 {
                let emptyNode = worldNodes.first(where: {$0.worldNode == node})
                emptyNode?.worldNode = nil
                
                node.moveTo(lastPos, duaration: 0.25) {
                    node.lastPos = nil
                }   
                if i < worldNodes.count - 1 {
                    if !worldNodes[i+1].isEmpty && worldNodes[i].isEmpty {
                        worldNodes[i+1].worldNode?.moveTo(worldNodes[i].position, duaration: 0.2){
                            self.enterButton.isUserInteractionEnabled = true
                        }
                        let temp = worldNodes[i+1].worldNode
                        worldNodes[i+1].worldNode = nil
//                        worldNodes[i+1].isBusy = false
//                        worldNodes[i].isBusy = true
                        worldNodes[i].worldNode = temp
                    }
                }
            }
            
          
        
            
        } else {
            guard !emptyWorldNodes.isEmpty else { return }

            let currPos = node.position
            let neededEmptyNode = emptyWorldNodes.first!
            neededEmptyNode.worldNode = node
            node.moveTo(neededEmptyNode.position, duaration: 0.25) {
                node.lastPos = currPos
            }
        }
    }
    
    
}
