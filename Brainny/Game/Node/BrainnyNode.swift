//
//  BrainnyNode.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 07.01.2025.
//

import SpriteKit

class BrainnyNode: SKSpriteNode {
    
    var shouldStartMoving: Bool = false {
        didSet {
            if !shouldStartMoving {
                stopMoving()
            }
        }
    }
    
    
    private var isMoving: Bool = false {
        didSet {
            if !isMoving {
                
            }
        }
    }
    
    
    var dieTextures: [SKTexture] {
        var arr = [SKTexture]()
        for i in 0 ... 7 {
            arr.append(SKTexture(imageNamed: "herpDie\(i.description)"))
        }
        return arr
    }
    
    var isRight: Bool = true
    var index: Int = 0
    var isCanMovig: Bool = true

    init() {
        let texture = SKTexture(imageNamed: "brainCharacter")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "character"
        
        xScale = 0.2
        yScale = 0.2
        
        setUpPhysicBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPhysicBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 10, height: self.size.height - 20))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.chrarcter
        
    }
    
    func die() {
        self.run(SKAction.animate(with: dieTextures, timePerFrame: 0.1)) {
            self.run(SKAction.fadeAlpha(to: 0, duration: 0.2)) {
                self.removeFromParent()
            }
        }
    }
    
    func startMoving() {
        guard shouldStartMoving, isCanMovig else { return }
        
        if !isMoving {
            isMoving = true
            jumping()
            AudioManager.shared.footstepsPlayer?.play()
        }
        if index % 15 == 0 {
            let footstep = FootstepNode(isRight: isRight)
            footstep.zPosition = self.zPosition - 1
            footstep.position.y = self.position.y
            if let scene = scene as? LightScene {
                scene.addChild(footstep)
            }
            isRight.toggle()
        }
        
        index += 1
      
        self.position.y += 3.5
    }
    
    
    func stopMoving() {
        AudioManager.shared.footstepsPlayer?.stop()
        isMoving = false
        
        self.removeAction(forKey: "jumping")
    }
    
    
    func jumping() {
        self.run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(to: 0.225, duration: 0.1), SKAction.scale(to: 0.2, duration: 0.1)])), withKey: "jumping")
    }
    
}
