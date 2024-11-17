//
//  VibrationManager.swift
//  Brainny
//
//  Created by Tanya Koldunova on 16.11.2024.
//

import UIKit
import AudioToolbox

func playPopVibration() {
    if !UserDefaultsValues.hapticOff {
        AudioServicesPlaySystemSound(1520)
    }
}
