//
//  UserDefaultsValues.swift
//  Brainny
//
//  Created by Tanya Koldunova on 02.10.2024.
//

import UIKit

public struct UserDefaultsValues {
    enum Keys {
        static let notificationOffKey = "com.notificationOff.key"
        static let soundOffKey = "com.soundOff.key"
        static let vibrationOffKey = "com.vibrationOff.key"
        static let volumeKey = "com.volume.key"
        static let coinsKey = "com.coins.key"
        static let touchCountKey = "com.touchCount.key"
        static let languagetKey = "com.language.key"
        
        //  static let noAdsKey = "com.noAds.key"
    }
    
    
    static func setdefaultData() {
        UserDefaults.standard.register(defaults: [Keys.volumeKey:0.07])
        UserDefaults.standard.register(defaults: [Keys.coinsKey:25])
    }
    
    static var coins: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.coinsKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.coinsKey)
        }
    }
    
    static var soundOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.soundOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.soundOffKey)
        }
    }
    
    static var hapticOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.vibrationOffKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.vibrationOffKey)
        }
    }
    
    static var volume: Float {
        get {
            return UserDefaults.standard.float(forKey: Keys.volumeKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.volumeKey)
        }
    }
    
    static var touchCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.touchCountKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.touchCountKey)
        }
    }
    
    static var language: Language {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.languagetKey) {
                if let model = try? JSONDecoder().decode(Language.self, from: data) {
                    return model
                }
            }
            return Language(rawValue: Locale.current.languageCode ?? "en") ?? .en
        } set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: Keys.languagetKey)
            }
        }
    }
}
    
