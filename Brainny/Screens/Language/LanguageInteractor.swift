//
//  LanguageInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import Foundation
import UIKit

protocol LanguageDelegate {
    func changedLanguage(language: Language)
}

protocol LanguageInteractorProtocol {
    var model: [Language] { get }
    var delegate: LanguageDelegate? {get}
    var currentLanguage: Language {get set}
    var oldValue: Language {get}
}

final class LanguageInteractor: LanguageInteractorProtocol {
    var currentLanguage: Language {
        didSet {
            UserDefaultsValues.language = currentLanguage
        }
    }
    var oldValue: Language
    var model: [Language]
    var delegate: LanguageDelegate?
    init(delegate: LanguageDelegate?) {
        self.model = Language.allCases
        self.delegate = delegate
        currentLanguage = UserDefaultsValues.language
        oldValue = UserDefaultsValues.language
    }
}
   
