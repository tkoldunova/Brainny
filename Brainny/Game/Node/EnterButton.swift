//
//  EnterButton.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 27.09.2024.
//

import SpriteKit

protocol EnterButtonDelegate: AnyObject {
    func touched(_ node: EnterButton)
}

class EnterButton: SKSpriteNode {
    
    lazy var rectangle : SKShapeNode = {
        let node = SKShapeNode(rectOf: self.size, cornerRadius: 16)
        node.fillColor = UIColor(red: 144/255, green: 123/255, blue: 209/255, alpha: 0.86)
        node.strokeColor = UIColor(red: 28/255, green: 201/255, blue: 159/255, alpha: 1)
        node.lineWidth = 3
        return node
    }()
    
    
    lazy var titleLabel: SKLabelNode = {
        let node = SKLabelNode()
        node.fontName = "OpenSans-SemiBold"
        node.zPosition = 1
        node.fontSize = 32
        node.text = "Enter"
        node.verticalAlignmentMode = .center
        return node
    }()
    
    weak var delegate: EnterButtonDelegate?
    
    init() {
        super.init(texture: nil, color: .clear, size: CGSize(width: 151, height: 45))
        
        addChild(rectangle)
        addChild(titleLabel)
        
        isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.group([SKAction.scale(to: 0.7, duration: 0.1), SKAction.fadeAlpha(to: 0.6, duration: 0.1)]))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.group([SKAction.scale(to: 0.7, duration: 0.1), SKAction.fadeAlpha(to: 0.6, duration: 0.1)]))
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(SKAction.group([SKAction.scale(to: 0.9, duration: 0.1), SKAction.fadeAlpha(to: 0.9, duration: 0.1)]))
        delegate?.touched(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
