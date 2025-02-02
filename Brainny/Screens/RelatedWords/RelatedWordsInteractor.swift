//
//  RelatedWordsInteractor.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

protocol RelatedWordsInteractorProtocol {
    var model: RelatedWords {get}
    var suggestion:String? {get set}
    var words: [WordsModel] {get set}
    var answers: [RelatedWordModel] {get set}
    var coins: Int {get set}
}

final class RelatedWordsInteractor: RelatedWordsInteractorProtocol {
    var model: RelatedWords
    var words: [WordsModel] {
        didSet {
          //  self.model.setWords(newValue: words)
        }
    }
    var answers: [RelatedWordModel] {
        didSet {
          //  self.model.setAnswers(newValue: answers)
        }
    }
    var coins: Int {
        didSet {
            UserDefaultsValues.coins = coins
        }
    }
    var suggestion:String?
    init(model: RelatedWords) {
        self.model = model
        self.suggestion = nil
        self.words = model.words
        self.answers = model.answer
        self.coins = UserDefaultsValues.coins
        
    }
}
