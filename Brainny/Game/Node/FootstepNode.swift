//
//  FootstepNode.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 15.01.2025.
//

import SpriteKit

class FootstepNode: SKSpriteNode {
    
    let isRight: Bool
    
    init(isRight: Bool) {
        self.isRight = isRight
    
        let texture = SKTexture(imageNamed: isRight ? "rightFootstep" : "leftFootstep")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "footsteps"
        xScale = 0.3
        yScale = 0.3
        self.position.x = isRight ? 10 : -10
        startLiving()
    }
    
    func startLiving() {
        self.run(SKAction.wait(forDuration: 4)) {
            self.run( SKAction.fadeAlpha(to: 0, duration: 0.15)) {
                self.removeFromParent()
            }
           
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
