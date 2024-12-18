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
    var detailModel: [DetailSettingsModel] {get}
    func getCount() -> Int
}

final class SettingsInteractor: SettingsInteractorProtocol {
    var swichableModel: [SettingsModel]
    var volumeModel: [VolumeModel]
    var detailModel: [DetailSettingsModel]
    init() {
        swichableModel = SettingsModel.allCases
        volumeModel = VolumeModel.allCases
        detailModel = DetailSettingsModel.allCases
    }

    
    func getCount() -> Int {
        return swichableModel.count + volumeModel.count + detailModel.count
    }
 
}
   
