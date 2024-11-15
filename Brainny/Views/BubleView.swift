//
//  BubleView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

protocol BubleViewDelegate {
    func touched(_ view: BubleView)
}

class BubleView: UIView {
    var game: Games?
    var delegate: BubleViewDelegate?
    var currentPath: UIBezierPath?
    var curvedLayer = CAShapeLayer()
    var myLayer = CALayer()  //
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 32)
        label.textColor = .white
        label.text = "Related Words"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width*0.206, y: rect.height*0.122))
        path.addCurve(to: CGPoint(x: 0.8468*rect.width, y: 0.004*rect.height),
                      controlPoint1: CGPoint(x: 0.4843*rect.width, y: rect.height*0.323076),
                      controlPoint2: CGPoint(x: 0.61875*rect.width, y: -rect.height*0.1307))
        
        path.addCurve(to: CGPoint(x: rect.width*0.8468, y: 0.9461*rect.height),
                      controlPoint1: CGPoint(x: 1.071*rect.width, y: 0.223*rect.height),
                      controlPoint2: CGPoint(x: 1.025*rect.width, y: 0.8*rect.height))
        
        path.addCurve(to: CGPoint(x: rect.width*0.246875, y: rect.height*0.946153),
                      controlPoint1: CGPoint(x: 0.6656*rect.width, y: 1.1*rect.height),
                      controlPoint2: CGPoint(x: 0.571875*rect.width, y: 0.630769*rect.height))
        path.addCurve(to: CGPoint(x: rect.width*0.206, y: rect.height*0.122),
                      controlPoint1: CGPoint(x: -0.078125*rect.width, y: 1.261538*rect.height),
                      controlPoint2: CGPoint(x: -0.075*rect.width, y: -0.07692*rect.height))
        
        curvedLayer.path = path.cgPath
        
        curvedLayer.fillColor = UIColor(patternImage: UIImage(named: "innerShadow")!).cgColor
        curvedLayer.frame = rect
        curvedLayer.lineWidth = 3.0
        curvedLayer.strokeColor = Colors.borderColor.cgColor
        
        //        myLayer.mask = curvedLayer
        //        myLayer.frame = curvedLayer.frame
        //        myLayer.backgroundColor = Colors.cellColor.cgColor
        self.layer.insertSublayer(curvedLayer, at: 0)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
    }
    
    
    func configureSubviews() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.identity
        })
        delegate?.touched(self)
    }
    
    
    
    func animation(startPath: UIBezierPath? = nil) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 1.5
        if let startPath = startPath {
            animation.fromValue = startPath.cgPath
        } else {
            animation.fromValue = curvedLayer.path
        }
        let path =  createRandomPath()
        animation.toValue = path.cgPath
        self.currentPath = path
        animation.delegate = self
        curvedLayer.add(animation, forKey: "wavyAnimation")
    }
    
    func createRandomPath() -> UIBezierPath {
        let rect = self.frame
        let path = UIBezierPath()
        let stratPoint = CGPoint(x: rect.width*CGFloat.random(in: 0.16 ... 0.306), y: rect.height*CGFloat.random(in: 0.03 ... 0.162))
        path.move(to: stratPoint)
        path.addCurve(to: CGPoint(x: CGFloat.random(in: 0.84 ... 0.9)*rect.width, y: CGFloat.random(in: 0.04...0.14)*rect.height),
                      controlPoint1: CGPoint(x: CGFloat.random(in: 0.48...0.58)*rect.width, y: rect.height*CGFloat.random(in: 0.32...0.42)),
                      controlPoint2: CGPoint(x: CGFloat.random(in: 0.61...0.7)*rect.width, y: -rect.height*CGFloat.random(in: 0.13...0.26))) //1.6
        
        path.addCurve(to: CGPoint(x: rect.width*CGFloat.random(in: 0.84 ... 0.9), y: CGFloat.random(in: 0.9 ... 0.95)*rect.height),
                      controlPoint1: CGPoint(x: CGFloat.random(in: 0.99...1.08)*rect.width, y: CGFloat.random(in: 0.22...0.3)*rect.height),
                      controlPoint2: CGPoint(x: CGFloat.random(in: 0.97...1.025)*rect.width, y: CGFloat.random(in: 0.61...0.8)*rect.height))
        
        path.addCurve(to: CGPoint(x: rect.width*CGFloat.random(in: 0.26 ... 0.3), y: rect.height*CGFloat.random(in: 0.89...0.95)),
                      controlPoint1: CGPoint(x: CGFloat.random(in: 0.66...0.8)*rect.width, y: CGFloat.random(in: 1.1...1.18)*rect.height),
                      controlPoint2: CGPoint(x: CGFloat.random(in: 0.5...0.6)*rect.width, y: CGFloat.random(in: 0.63...0.75)*rect.height))
        path.addCurve(to: stratPoint,
                      controlPoint1: CGPoint(x: -rect.width * CGFloat.random(in: 0.01...0.12), y: CGFloat.random(in: 1.03...1.06)*rect.height),
                      controlPoint2: CGPoint(x: -rect.width*CGFloat.random(in: 0.06...0.09), y: -rect.height*CGFloat.random(in: 0.03...0.07)))
        return path
        
        
        
    }
    
}

extension BubleView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            curvedLayer.path = currentPath?.cgPath
            animation(startPath: currentPath)
            
        }
    }
}


extension CALayer {
    // Function to render CALayer (including CAGradientLayer) into a UIImage
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
