//
//  UIView.swift
//  Brainny
//
//  Created by Tanya Koldunova on 25.09.2024.
//

import UIKit
extension UIView {
    
    func loadFromNib(nib: AnyObject.Type)->UIView? {
       let nibName = String(describing: nib.self)
       let bundle = Bundle(for: type(of: self))
       let nib = UINib(nibName: nibName, bundle: bundle)
       return nib.instantiate(withOwner: self, options: nil).first as? UIView
   }
    
    
    func shake(repeated: Bool = true) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        if repeated {
            animation.repeatCount = Float.greatestFiniteMagnitude
        }
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0, 0.0,]
       
        layer.add(animation, forKey: "shake")
    }
    
    
    func applyShadow(color: UIColor = .black, offset: CGSize = CGSize(width: 0, height: 4), radius: CGFloat = 4) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset// CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = radius//4
    }
    
    
    func fillSuperview(padding: UIEdgeInsets = UIEdgeInsets.zero) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide sides: [ViewSide], withColor color: CGColor, andThickness thickness: CGFloat) {
        for item in self.layer.sublayers ?? [] where item.name == "borderLeft" ||  item.name == "borderRight" || item.name == "borderTop" || item.name == "borderBottom" {
            item.removeFromSuperlayer()
        }
        //  layer.sublayers?.removeLast()
        for side in sides {
            let border = CALayer()
            border.backgroundColor = color
            switch side {
            case .Left:
                border.name = "borderLeft"
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height);
                layer.addSublayer(border)
            case .Right:
                border.name = "borderRight"
                border.frame = CGRect(x: frame.width-thickness, y: 0, width: thickness, height: frame.height);
                layer.addSublayer(border)
            case .Top:
                border.name = "borderTop"
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness);
                //border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
                layer.addSublayer(border)
            case .Bottom:
                border.name = "borderBottom"
                border.frame = CGRect(x: 0, y: frame.height + thickness + 2, width: frame.width, height: thickness);
                //border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
                layer.addSublayer(border)
            }
            
            
        }
        
    }
}
