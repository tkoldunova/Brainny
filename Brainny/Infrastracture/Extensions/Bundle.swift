//
//  Bundle.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//
import Foundation

private var bundleKey: UInt8 = 0

final class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle ?? Bundle.main
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    class func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, BundleEx.self)
        }
        
        let isLanguageValid = Bundle.main.path(forResource: language, ofType: "lproj") != nil
        guard let path = isLanguageValid ? Bundle.main.path(forResource: language, ofType: "lproj") : nil else {
            objc_setAssociatedObject(Bundle.main, &bundleKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return
        }
        
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: path), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
