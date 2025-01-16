//
//  LightScene.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 07.01.2025.
//

import SpriteKit

class LightScene: SKScene {
    
    lazy var characterNode: BrainnyNode =  {
        let node = BrainnyNode()
        node.zPosition = 3
        node.position = CGPoint(x: 0, y: 0)
        return node
    }()
    
    
    lazy var cameraNode: CameraNode = {
        let cameraNode = CameraNode()
//        cameraNode.verticalRange = ((bgNode.position.y - (bgNode.size.height - size.height)/2) ... (bgNode.position.y + (bgNode.size.height - size.height)/2))
//        cameraNode.horizontalRange = ((bgNode.position.x - (bgNode.size.width - size.width)/2) ... (bgNode.position.x + (bgNode.size.width - size.width)/2))
        cameraNode.leadingNode = characterNode
        return cameraNode
    }()
    
    lazy var traficLine: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "traficLine")
        node.zPosition = 100
        node.size = CGSize(width: 24, height: 4)
        node.xScale = 1.5
        node.yScale = 1.5
        node.position = CGPoint(x: -size.width/2 + node.size.width/2, y: size.height/2 - 100)
        return node
    }()
    
    lazy var trafictLight : TrafficLight = {
        let node = TrafficLight()
        node.zPosition = 102
        node.xScale = 2.5
        node.yScale = 2.7
        node.position = CGPoint(x: traficLine.position.x + traficLine.size.width/2 + node.size.width/2 - 2, y: traficLine.position.y)
        return node
    }()
    
    
    var points: Int = 0 {
        didSet {
            if oldValue != points {
                print(points.description)
            }
        }
    }
    
    var startedTime: Date?
    
    
    var isLose: Bool = false
    
    
    override func didMove(to view: SKView) {
        spawn()
        setUpCamera()
        addChild(characterNode)
        
        setUpPhysicWorld()
        trafictLight.shouldShowGreenLight = true
    }
    
    
    func setUpPhysicWorld() {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = .zero
    }
    
    func spawn() {
        let crossWalks = children.filter({$0.name == "crossWalk"}) as! [SKSpriteNode]
        
        for i in 0 ... 300 {
            let node = SKSpriteNode(imageNamed: "rect")
            
            
            let startY = crossWalks.isEmpty ? -size.height/2 + node.size.height/2 + 30 : crossWalks.last!.position.y + node.size.height + 30
            
            node.position = CGPoint(x: 0, y: startY + (node.size.height + 30) * CGFloat(i))
            node.size.width = self.size.width/1.7
            node.name = "crossWalk"
            node.zPosition = 1
            
            
            addChild(node)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        characterNode.startMoving()
        cameraNode.follow()
        
        points = Int(characterNode.position.y/10)
        
        var isLose = false
        
        isLose = trafictLight.isRedLight && characterNode.shouldStartMoving
        
        
        if isLose {
            print("Lose")
            
            if !self.isLose {
                self.isLose = true
                self.run(SKAction.wait(forDuration: 1)) {
                    AudioManager.shared.footstepsPlayer?.stop()
                    self.characterNode.isCanMovig = false
                    
                    let car = CarNode()
                    car.zPosition = 5
                    car.position = CGPoint(x: self.size.width/2 + 100, y:  self.characterNode.position.y - self.characterNode.size.height/2 + car.size.height/2 + 10)
                    self.addChild(car)
                    car.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 0))
                    self.run(SKAction.wait(forDuration: 0.1)) {
                        self.run(SKAction.playSoundFileNamed("beeb.mp3", waitForCompletion: false))
                    }
                }
             
//                car.run(SKAction.moveTo(x: characterNode.position.x, duration: 2))
            }
        }
        
        
        let crossWalks = children.filter({$0.name == "crossWalk"}) as! [SKSpriteNode]
        
        if let lastCrossWalk = crossWalks.last {
            if lastCrossWalk.position.y - cameraNode.position.y < 170 {
                print("Spawn")
                spawn()
            }
        }
    }
    
    func setUpCamera() {
        camera = cameraNode
        
        addChild(cameraNode)
        cameraNode.addChild(traficLine)
        cameraNode.addChild(trafictLight)
//        cameraNode.addChild(jumpButton)
//        cameraNode.setUpPosition(characterNode.position)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        characterNode.shouldStartMoving = true
        
        startedTime = Date()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if Date() - startedTime! > 0.2 {
            characterNode.shouldStartMoving = false
        } else {
            run(SKAction.wait(forDuration: 0.2 -  (Date() - startedTime!))) {
                self.characterNode.shouldStartMoving = false
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if Date() - startedTime! > 0.2 {
            characterNode.shouldStartMoving = false
        } else {
            run(SKAction.wait(forDuration: 0.2 -  (Date() - startedTime!))) {
                self.characterNode.shouldStartMoving = false
            }
        }
    }
}



extension LightScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask)
        
        if collision == PhysicCategory.car | PhysicCategory.chrarcter {
            if let bodyA = contact.bodyA.node as? CarNode, let bodyB = contact.bodyB.node as? BrainnyNode {
                contactCarWithBrain(bodyA, bodyB)
            } else if let bodyA = contact.bodyB.node as? CarNode, let bodyB = contact.bodyA.node as? BrainnyNode {
                contactCarWithBrain(bodyA, bodyB)
            }
        }
    }
    
    
    func contactCarWithBrain(_ bodyA: CarNode, _ bodyB: BrainnyNode) {
        guard !bodyA.isContactHappened else { return }
        
        bodyA.isContactHappened = true
        
        bodyB.die()
        
        let circle = SKSpriteNode(imageNamed: "smash")
        circle.position = CGPoint(x: bodyB.position.x, y: bodyB.position.y)
        circle.xScale = 0.2
        circle.yScale = 0.2
        circle.zPosition = bodyB.zPosition - 1
        circle.alpha = 0
        self.addChild(circle)
        self.run(SKAction.wait(forDuration: 0.3)) {
            circle.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
        }
        
    }
    
    
}
