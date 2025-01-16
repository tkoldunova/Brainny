//
//  TrafficLight.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 07.01.2025.
//

import SpriteKit

class TrafficLight: SKSpriteNode {
    
    
    var points: Int? {
        if let scene = scene as? LightScene {
            return scene.points
        }
        
        return nil
    }
    
    var isRedLight: Bool = false
    
    var shouldShowGreenLight: Bool = true {
        didSet {
            let lights = children.filter({$0.name == "traffic_light"}) as! [SKShapeNode]
            self.run(SKAction.playSoundFileNamed("green.mp3", waitForCompletion: false))
            lights[0].fillColor = UIColor(red: 72/255, green: 189/255, blue: 97/255, alpha: 1)
            
            let randomDur = TimeInterval.random(in: 1 ... 6)
            
            
            
            self.run(SKAction.wait(forDuration: randomDur)) {
                lights[0].fillColor = SKColor(red: 56/255, green: 54/255, blue: 54/255, alpha: 1)
                self.run(SKAction.repeat(SKAction.sequence([SKAction.run {
                    lights[1].fillColor = UIColor(red: 239/255, green: 94/255, blue: 11/255, alpha: 1)
                }, SKAction.wait(forDuration: self.points ?? 0 > 350 ? 0.045 : self.points ?? 0 > 375 ? 0.055 : self.points ?? 0  > 200 ? 0.057 : self.points ?? 0 > 100 ? 0.062 : 0.07), SKAction.run {
                    lights[1].fillColor = SKColor(red: 56/255, green: 54/255, blue: 54/255, alpha: 1)
                }, SKAction.wait(forDuration:  self.points ?? 0 > 250 ? 0.045 : self.points ?? 0 > 200 ? 0.055 : self.points ?? 0  > 150 ? 0.057 : self.points ?? 0 > 100 ? 0.062 : 0.07)]), count: 2)) {
                    self.isRedLight = true
                    self.run(SKAction.playSoundFileNamed("red.mp3", waitForCompletion: false))
                    lights[2].fillColor = UIColor(red: 226/255, green: 50/255, blue: 50/255, alpha: 1)
                    
                    self.run(SKAction.wait(forDuration: TimeInterval.random(in: 1 ... 5))) {
                        self.isRedLight = false
                        lights[2].fillColor = SKColor(red: 56/255, green: 54/255, blue: 54/255, alpha: 1)
                        self.shouldShowGreenLight.toggle()
                    }
                }
            }
            
        }
    }
    
    init() {
        let texture = SKTexture(imageNamed: "traficLight")
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        name = "trafic light"
        
        setUpLight()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpLight() {
        for i in 0 ... 2 {
            let circle = SKShapeNode(circleOfRadius: 11/2)
            circle.fillColor = SKColor(red: 56/255, green: 54/255, blue: 54/255, alpha: 1)
            circle.strokeColor = .clear
            circle.name = "traffic_light"
            
            circle.zPosition = 3
            let startX = -size.width/2 + 3 + 11/2
            circle.position = CGPoint(x: startX + (11 + 5) * CGFloat(i), y: 0)
            
            addChild(circle)
            
            
//
        }
    }
    
}
