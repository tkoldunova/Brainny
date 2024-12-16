//
//  LoaderInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.12.2024.
//

import Foundation

import UIKit

protocol LoaderInteractorProtocol {
    var animationDration: TimeInterval {get}
}

final class LoaderInteractor: LoaderInteractorProtocol {
    var animationDration: TimeInterval
   
    init() {
        self.animationDration = 4
    }
}
