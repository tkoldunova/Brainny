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
}
