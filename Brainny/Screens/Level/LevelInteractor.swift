//
//  LevelInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//


import UIKit

protocol LevelInteractorProtocol {
    var model: Games {get}
}

final class LevelInteractor: LevelInteractorProtocol {
    var model: Games
   
    init(model: Games) {
        self.model = model
    }
}
