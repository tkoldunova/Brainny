//
//  EmptyNode.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 27.09.2024.
//

import SpriteKit

class EmptyNode: SKSpriteNode {
    
    weak var worldNode: WorldNode?
    
    var isEmpty: Bool {
        return worldNode == nil
    }
    
    init(size: CGSize) {
        let texture = SKTexture(imageNamed: "worldNode")
        
        super.init(texture: texture, color: .clear, size: size)
        name = "empty_node"
         zPosition = 5
         alpha = 0.6
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

}
