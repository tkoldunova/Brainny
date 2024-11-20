//
//  SecretWordsInteractoe.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//
import UIKit

protocol SecretWordsInteractorProtocol {
    var model: SecretWords {get}
    var suggestion:String? {get set}
    var words: [WordsModel] {get set}
    var answer: RelatedWordModel {get set}
    var coins: Int {get set}
}

final class SecretWordsInteractor: SecretWordsInteractorProtocol {
    var model: SecretWords
    var words: [WordsModel] {
        didSet {
        //    self.model.setWords(newValue: words)
        }
    }
    var answer: RelatedWordModel {
        didSet {
          //  self.model.setAnswers(newValue: answer)
        }
    }
    var coins: Int {
        didSet {
            UserDefaultsValues.coins = coins
        }
    }
    var suggestion:String?
    init(model: SecretWords) {
        self.model = model
        self.suggestion = nil
        self.words = model.words
        self.answer = model.answer
        self.coins = UserDefaultsValues.coins
        
    }
}
