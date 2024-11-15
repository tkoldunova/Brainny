//
//  NotificationManager.swift
//  Brainny
//
//  Created by Tanya Koldunova on 15.11.2024.
//

import Foundation

class NotificationManager {
    
     static func showMesssage(theme : SwiftMessageType, title : String, message : String, actionText : String?, duration : SwiftDuration, action : (() -> Void)?) {
         SwiftMessage.show(title: title, message: message, type: theme, actionText: actionText, action: action, duration: duration)

    }
}
