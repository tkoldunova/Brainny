//
//  FlagUtils.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import UIKit
class FlagUtils {
    class func getflagByName(country: String) -> String {
        var abbr = country
         if abbr == "" {
            return "🏳️"
        }
        let base : UInt32 = 127397
        var s = ""
        for v in abbr.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }

    class func emojiToImage(emoji: String)-> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (emoji as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
