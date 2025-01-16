//
//  CameraNode.swift
//  LuckyElf2
//
//  Created by Anastasia Koldunova on 23.09.2024.
//

import SpriteKit


class CameraNode: SKCameraNode {
    
    var horizontalRange: ClosedRange<CGFloat>?
    var verticalRange: ClosedRange<CGFloat>?
    weak var leadingNode: SKSpriteNode?
    
    
    func follow() {
        guard let leadingNodePosition = leadingNode?.position/*, let verticalRange = verticalRange, let horizontalRange = horizontalRange*/ else {
            return
        }

//        if horizontalRange.contains(leadingNodePosition.x) {
        position.x = leadingNodePosition.x
//        }
//        if verticalRange.contains(leadingNodePosition.y) {
            position.y = leadingNodePosition.y
//        }

    }
    
    
    func moveTo(point: CGPoint) {
        
//        guard let verticalRange = verticalRange, let horizontalRange = horizontalRange else { return }
        
        print("move!!!!")
//        if verticalRange.contains(point.y) {
            position.y = point.y
//        }
        
//        if horizontalRange.contains(point.x) {
            position.x = point.x
//        }
    }
    
    
    func setUpPosition(_ position: CGPoint) {
        if let horizontalRange = horizontalRange {
            var x = position.x
            while x > horizontalRange.upperBound {
                x -= 1
            }
            
            while x < horizontalRange.lowerBound {
                x += 1
            }
            self.position.x = x
        }
        if let verticalRange = verticalRange {
            var y = position.y
            
            while y > verticalRange.upperBound {
                y -= 1
            }
            
            while y < verticalRange.lowerBound {
                y += 1
            }
            
            self.position.y = y
        }
    }
    
}
