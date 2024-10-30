//
//  SKSpriteNode.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 18.10.2024.
//

import SpriteKit

extension SKSpriteNode {
        func addGlow(radius: CGFloat = 30) {
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let view = SKView()
           let effectNode = SKEffectNode()
           effectNode.shouldRasterize = true
//            effectNode.position = CGPoint(x: size.width/2, y: -size.height/2)
           effectNode.name = "effectedNode"
            effectNode.shouldCenterFilter = false
            let effect = SKSpriteNode(texture: view.texture(from: self))
            effect.color = .white
           effect.colorBlendFactor = 1
           effectNode.addChild(effect)
           effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius":radius])
            addChild(effectNode)
       }
    
    func shake(duration:Float, completion: @escaping ()->Void) {
        let amplitudeX:Float = 20;
        let amplitudeY:Float = 0;
        let numberOfShakes = duration / 0.08;
        var actionsArray:[SKAction] = [];
        for _ in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02)
            shakeAction.timingMode = SKActionTimingMode.easeOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversed());
        }
        actionsArray.append(SKAction.run {
            completion()
        })
        let actionSeq = SKAction.sequence(actionsArray);
        self.run(actionSeq);
    }
    
    func removeGlowEffect() {
        let effectNode = childNode(withName: "effectedNode")
        effectNode?.removeFromParent()
    }
}
