//
//  WorldNode.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 27.09.2024.
//

import SpriteKit

protocol WorldNodeDelegate: AnyObject {
    func touched(_ node: WorldNode)
}

class WorldNode: SKSpriteNode {
    
    var lastPos: CGPoint?
    
    
    var char: String? {
        didSet {
            titleLabel.text = char
        }
    }
    
    weak var delegate: WorldNodeDelegate?
    
    lazy var titleLabel: SKLabelNode = {
        let node = SKLabelNode()
        node.fontName = "OpenSans-SemiBold"
        node.zPosition = 1
        node.fontSize = 32
        node.verticalAlignmentMode = .center
        return node
    }()
    
    init() {
        let texture = SKTexture(imageNamed: "worldNode")
        super.init(texture: texture, color: .clear, size: CGSize(width: 45, height: 45))
        
        zPosition = 7
        name = "word_node"
        addChild(titleLabel)
        
        isUserInteractionEnabled = true
    }
    
    func moveTo(_ point: CGPoint, duaration: TimeInterval, completion: @escaping () -> Void) {
        let action = SKAction.move(to: point, duration: duaration)
        action.timingMode = .easeOut
        self.run(action, completion: completion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.group([SKAction.scale(to: 0.9, duration: 0.1), SKAction.fadeAlpha(to: 0.9, duration: 0.1)]))
        delegate?.touched(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.group([SKAction.scale(to: 0.9, duration: 0.1), SKAction.fadeAlpha(to: 0.9, duration: 0.1)]))
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.group([SKAction.scale(to: 0.9, duration: 0.1), SKAction.fadeAlpha(to: 0.9, duration: 0.1)]))
    }
    
}
