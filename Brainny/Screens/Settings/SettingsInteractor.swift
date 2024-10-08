//
//  SettingsInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 05.10.2024.
//
import UIKit
protocol SettingsInteractorProtocol {
    var swichableModel: [SettingsModel] {get}
    var volumeModel: [VolumeModel] {get}
    func getCount() -> Int
}

final class SettingsInteractor: SettingsInteractorProtocol {
    var swichableModel: [SettingsModel]
    var volumeModel: [VolumeModel]
    init() {
        swichableModel = SettingsModel.allCases
        volumeModel = VolumeModel.allCases
    }

    
    func getCount() -> Int {
        return swichableModel.count + volumeModel.count 
    }
 
}
   
