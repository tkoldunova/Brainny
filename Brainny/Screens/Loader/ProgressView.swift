//
//  ProgressView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.12.2024.
//

import UIKit

import UIKit
protocol ProgressDelegate {
    func end()
}

@IBDesignable
class ProgreeView: UIView {
    var timer = Timer()
    private var time: TimeInterval = 0 {
        didSet {
            progress = time / maxTime
            print("progress " + progress.description)
        }
    }
    var maxTime: TimeInterval = 0
    private let borderLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    var delegate: ProgressDelegate?
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
    }
    override func draw(_ rect: CGRect) {
        //borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height*0.35).cgPath
        borderLayer.lineWidth = 2.0
        borderLayer.strokeColor = UIColor(red: 28/255, green: 201/255, blue: 159/255, alpha: 1).cgColor
        borderLayer.fillColor = UIColor(red: 144/255, green: 123/255, blue: 209/255, alpha: 1).cgColor
        layer.addSublayer(borderLayer)
        let progressMask = CAShapeLayer()
        progressMask.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 4, y: 4), size: CGSize(width: (rect.width - 8), height: (rect.height-8))), cornerRadius: rect.width*0.1).cgPath
        progressLayer.path =  UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 4, y: 4), size: CGSize(width: (rect.width - 8) * progress, height: (rect.height-8))), cornerRadius: rect.width*0.1).cgPath
        progressLayer.fillColor = UIColor(red: 106/255, green: 69/255, blue: 219/255, alpha: 1).cgColor
        progressLayer.mask = progressMask
        layer.addSublayer(progressLayer)

    }

    func animate(duration: TimeInterval) {
        self.maxTime = duration
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.time += 0.01
            if self.time >= self.maxTime {
                self.timer.invalidate()
                self.delegate?.end()
            }
        }
    }
    
    func stop() {
        timer.invalidate()
    }
}
