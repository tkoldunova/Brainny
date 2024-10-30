//
//  SettingsModel.swift
//  Brainny
//
//  Created by Tanya Koldunova on 05.10.2024.
//

import UIKit

enum SettingsModel: CaseIterable {
    case sound
    case haptics
    
    
    var title: String {
        switch self {
        case .sound:
            return NSLocalizedString("settings.model.sound", comment: "")
        case .haptics:
            return NSLocalizedString("settings.model.haptic", comment: "")
        }
    }
    
    var image: UIImage {
        return UIImage(named: String(describing: self))!
    }
    
    var isOn: Bool {
        switch self {
        case .sound:
            return !UserDefaultsValues.soundOff
        case .haptics:
            return !UserDefaultsValues.hapticOff
        }
    }
    
    func valueChanged(newValue: Bool) {
        switch self {
        case .sound:
            UserDefaultsValues.soundOff = !newValue
            if !UserDefaultsValues.soundOff {
             //   AudioManager.shared.playPressedSound()
            }
        case .haptics:
            UserDefaultsValues.hapticOff = !newValue
            if !UserDefaultsValues.hapticOff {
            //    playPopVibration()
            }
        }
    }
}

enum VolumeModel: CaseIterable {
    case music
    
    var title: String {
        switch self {
        case .music:
            return NSLocalizedString("settings.model.music", comment: "")
        }
    }
    
    
    var image: UIImage {
        switch self {
        case .music:
            return UIImage(named: "music")!
        }
    }
    
    var value: Float {
        switch self {
        case .music:
            return UserDefaultsValues.volume
        }
    }
    
    func valueChanged(volume: Float) {
        switch self {
        case .music:
            UserDefaultsValues.volume = volume
         //   AudioManager.shared.changeMusicVolume()
        }
    }

}
