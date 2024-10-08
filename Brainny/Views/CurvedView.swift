//
//  CurvedView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

class CurvedView: UIView {
    var curvedLayer = CAShapeLayer()
    
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0, y: rect.height*0.85))
//        path.addCurve(to: CGPoint(x: rect.width, y: rect.height), controlPoint1: CGPoint(x: 0.18*rect.width, y: 1.07*rect.height), controlPoint2: CGPoint(x: 0.67*rect.width, y: 0.64*rect.width))
//        path.addLine(to: CGPoint(x: rect.width, y: 0))
//        // path.addLine(to: CGPoint(x: , y: 0))
//        curvedLayer.path = path.cgPath
//        curvedLayer.fillColor = UIColor(red: 116/255, green: 70/255, blue: 255/255, alpha: 1).cgColor
//        curvedLayer.frame = rect
//        self.layer.insertSublayer(curvedLayer, at: 0)
//    }
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height-62))
        path.addCurve(to: CGPoint(x: rect.width, y: rect.height), controlPoint1: CGPoint(x: 66, y: rect.height+28), controlPoint2: CGPoint(x: rect.width - 130, y: rect.height - 158))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        // path.addLine(to: CGPoint(x: , y: 0))
        curvedLayer.path = path.cgPath
        curvedLayer.fillColor = UIColor(red: 116/255, green: 70/255, blue: 255/255, alpha: 1).cgColor
        curvedLayer.frame = rect
        self.layer.insertSublayer(curvedLayer, at: 0)
    }
    
    
}
