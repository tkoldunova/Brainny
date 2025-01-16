//
//  CarNode.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 14.01.2025.
//

import SpriteKit

class CarNode: SKSpriteNode {
    
    var isContactHappened: Bool = false
    
    init() {
        
        let texture = SKTexture(imageNamed: "car")
        
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        xScale = 0.85
        yScale = 0.85
        
        setUpPhysicBody()
    }
    
    
    private func setUpPhysicBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 10, height: self.size.height - 30))
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.car
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = PhysicCategory.chrarcter
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
