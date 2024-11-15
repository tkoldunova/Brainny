//
//  SwiftMessageView.swift
//  Fortune
//
//  Created by Tanya Koldunova on 22.03.2024.
//

import UIKit

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor {
            print($0.userInterfaceStyle == .dark)
            return $0.userInterfaceStyle == .dark ? dark : light
        }
    }
}



enum SwiftDuration {
    case automatic
    case forever
    case seconds(TimeInterval)
}

enum SwiftMessageType {
    case success
    case error
    case warning
    case info
    
    
    
    var icon: UIImage? {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle")
        case .error:
            return UIImage(systemName: "xmark.circle")
        case .warning:
            return UIImage(systemName: "exclamationmark.circle")
        case .info:
            return UIImage(systemName: "info.circle")
        }
    }
    
    var lightColor: UIColor {
        switch self {
        case .success:
            return UIColor(red: 113/255, green: 198/255, blue: 131/255, alpha: 1)
        case .error:
            return UIColor(red: 218/255, green: 102/255, blue: 86/255, alpha: 1)
        case .warning:
            return UIColor(red: 250/255, green: 216/255, blue: 96/255, alpha: 1)
        case .info:
            return UIColor(red: 121/255, green: 149/255, blue: 184/255, alpha: 1)
        }
    }
    
    var darkColor: UIColor {
        switch self {
        case .success:
            return UIColor(red: 75/255, green: 141/255, blue: 89/255, alpha: 1)
        case .error:
            return UIColor(red: 148/255, green: 67/255, blue: 55/255, alpha: 1)
        case .warning:
            return UIColor(red: 163/255, green: 139/255, blue: 55/255, alpha: 1)
        case .info:
            return UIColor(red: 44/255, green: 54/255, blue: 66/255, alpha: 1)
        }
    }
    
    var lightButtonColor: UIColor {
        switch self {
        case .success:
            return UIColor(red: 107/255, green: 224/255, blue: 132/255, alpha: 1)
        case .error:
            return UIColor(red: 239/255, green: 115/255, blue: 97/255, alpha: 1)
        case .warning:
            return UIColor(red: 255/255, green: 226/255, blue: 124/255, alpha: 1)
        case .info:
            return UIColor(red: 152/255, green: 177/255, blue: 208/255, alpha: 1)
        }
    }
    
    var darkButtonColor: UIColor {
        switch self {
        case .success:
            return UIColor(red: 100/255, green: 201/255, blue: 121/255, alpha: 1)
        case .error:
            return UIColor(red: 212/255, green: 87/255, blue: 69/255, alpha: 1)
        case .warning:
            return UIColor(red: 234/255, green: 197/255, blue: 68/255, alpha: 1)
        case .info:
            return UIColor(red: 52/255, green: 67/255, blue: 86/255, alpha: 1)
        }
    }
}

class SwiftMessage {
    //    var view: SwiftMessageView
    //    var presenter: SwiftMessagePresenter
    //    var duration: SwiftDuration
    
    static func show(title: String, message: String?, type: SwiftMessageType, duration: SwiftDuration = .automatic) {
        let presenter: SwiftMessagePresenter = SwiftMessagePresenter()
        let width = presenter.window?.frame.width ?? UIScreen.main.bounds.width
        let view = SwiftMessageView(width: width*0.9, title: title, message: message, type: type)
        presenter.show(view: view)
        switch duration {
        case .automatic:
            DispatchQueue.main.asyncAfter(deadline: .now()+5.0, execute: {
                presenter.hide(view: view)
            })
        case .forever:
            return
        case .seconds(let timeInterval):
            DispatchQueue.main.asyncAfter(deadline: .now()+timeInterval, execute: {
                presenter.hide(view: view)
            })
        }
    }
    
    static func show(title: String, message: String?, type: SwiftMessageType, actionText: String?, action: (()->Void)?, duration: SwiftDuration = .automatic) {
        let presenter: SwiftMessagePresenter = SwiftMessagePresenter()
        let width = presenter.window?.frame.width ?? UIScreen.main.bounds.width
        let view = SwiftMessageView(width: width*0.9, title: title, message: message, type: type, actionText: actionText, action: action)
        presenter.show(view: view)
        switch duration {
        case .automatic:
            DispatchQueue.main.asyncAfter(deadline: .now()+5.0, execute: {
                presenter.hide(view: view)
            })
        case .forever:
            return
        case .seconds(let timeInterval):
            DispatchQueue.main.asyncAfter(deadline: .now()+timeInterval, execute: {
                presenter.hide(view: view)
            })
        }
    }
    
}


class SwiftMessagePresenter: NSObject {
    var window: UIWindow?
    
    override init() {
        //  size = UIScreen.main.bounds.size
        super.init()
        if let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .first as? UIWindowScene {
            if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                self.window = keyWindow
                
            }
        }
    }
    
    func show(view: UIView) {
        updateWindow()
        guard let keyWindow = window else {return}
        let size = view.frame.size
        view.frame = CGRect(origin: CGPoint(x: 0, y: -size.height), size: size)
        view.center.x = keyWindow.center.x
        keyWindow.addSubview(view)
        keyWindow.bringSubviewToFront(view)
        UIView.animate(withDuration: 0.5, animations: {
            view.frame.origin.y = 56
        })
    }
    
    func hide(view: SwiftMessageView) {
        
        let size = view.frame.size
        view.myGestureRecognizer.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            view.frame.origin.y = -size.height
        }) { res in
            if res {
                view.removeFromSuperview()
            }
        }
    }
    
    
    private func updateWindow() {
        if let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .first as? UIWindowScene {
            if let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                window = keyWindow
            }
        }
        
    }
    
}



class SwiftMessageView: UIView {
    private var initialPoint = CGPoint.zero
    private var prevTranslation: CGFloat = 0
    private var title: String
    private var message: String?
    private var action: (() -> Void)?
    var type: SwiftMessageType
    lazy var iconView: UIImageView = {
        let imgView = UIImageView(image: type.icon)
        imgView.tintColor = .white
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = -2
        stackView.addArrangedSubview(titleLabel)
        if message != nil {
            stackView.addArrangedSubview(messageLabel)
        }
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.addArrangedSubview(verticalStackView)
        return stackView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.dynamicColor(light: type.lightButtonColor, dark: type.darkButtonColor)
        button.layer.cornerRadius = 16.0
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45),
            button.widthAnchor.constraint(equalToConstant: 90)
        ])
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    lazy var myGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(hideView(_:)))
    //    lazy var  = U//UISwipeGestureRecognizer(target: self, action: #selector(hideView(_:)))
    
    init(width: CGFloat, title: String, message: String?, type: SwiftMessageType) {
        self.title = title
        self.message = message
        self.type = type
        var additionalSpace: CGFloat = (!title.isEmpty && !(message?.isEmpty ?? true)) ? 16 : 0
        let height: CGFloat = 56 + additionalSpace + ((CGFloat(message?.count ?? 0)/36) - 1.0)*18
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.backgroundColor = UIColor.dynamicColor(light: type.lightColor, dark: type.darkColor)
        self.layer.cornerRadius = 24
        self.addGestureRecognizer(myGestureRecognizer)
        configureSubviews()
        titleLabel.text = title
        messageLabel.text = message
        
    }
    
    init(width: CGFloat, title: String, message: String?, type: SwiftMessageType, actionText: String?, action: (()->Void)?) {
        self.title = title
        self.message = message
        self.type = type
        var additionalSpace: CGFloat = 12
        let div : CGFloat = (action != nil) ? 28 : 36
        if action != nil {
            additionalSpace = 8
        }
        if !title.isEmpty && !(message?.isEmpty ?? true) {
            additionalSpace = 16
        }
        let height: CGFloat = 56 + additionalSpace + ((CGFloat(message?.count ?? 0)/div) - 1.0)*18.0
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.backgroundColor = UIColor.dynamicColor(light: type.lightColor, dark: type.darkColor)
        self.layer.cornerRadius = 24
        if let actionText = actionText, let action = action {
            configureAction(actionText: actionText, action: action)
        }
        self.addGestureRecognizer(myGestureRecognizer)
        configureSubviews()
        titleLabel.text = title
        messageLabel.text = message
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAction(actionText: String, action: @escaping ()->Void) {
        self.action = action
        let attrText = NSAttributedString(string: actionText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ])
        button.setAttributedTitle(attrText, for: .normal)
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        horizontalStackView.addArrangedSubview(button)
    }
    
    @objc func buttonTouched() {
        action?()
    }
    
    @objc func hideView(_ sender: Any) {
        if let sender = sender as? UIPanGestureRecognizer {
           
            let translation = sender.translation(in: window ?? self)
            let velocity = sender.velocity(in: window ?? self)
            print("translation: \(translation)")
            print("velocity: \(velocity)")
           // print(self.frame.debugDescription)
            if sender.state == .began {
                initialPoint.y = self.frame.origin.y
              
            } else if sender.state == .changed {
                print("frame: \(self.frame)")
                print("translation: \(translation)")
                if self.frame.origin.y < 60 && translation.y < 0 {
                self.frame.origin.y = initialPoint.y + translation.y
                   
                }
               
            } else if sender.state == .ended {
                if self.frame.origin.y < 25 {
                    let size = self.frame.size
                    UIView.animate(withDuration: 0.25, animations: {
                        self.frame.origin.y -= size.height
                    }) { res in
                        if res {
                            self.removeFromSuperview()
                        }
                    }
                }
            }
        }
        //
        //
    }
    
    func configureSubviews() {
        self.addSubview(iconView)
        self.addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            iconView.widthAnchor.constraint(equalToConstant: 32),
            iconView.heightAnchor.constraint(equalToConstant: 32),
            horizontalStackView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    
    
    
}
