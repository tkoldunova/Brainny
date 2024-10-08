//
//  MenuInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 28.09.2024.
//
import UIKit

protocol MenyInteractorProtocol {
    var model: [Games] {get}
}

final class MenuInteractor: MenyInteractorProtocol {
    var model: [Games]
   
    init() {
        self.model = Games.allCases
    }
}
