//
//  SecretWords.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//

import UIKit

enum SecretWords: CaseIterable, LevelProtocol {
    case lv1
    case lv2
    case lv3
    case lv4
    case lv5
    case lv6
    case lv7
    case lv8
    case lv9
    case lv10
    case lv11
    case lv12
    case lv13
    case lv14
    case lv15
    case lv16
    case lv17
    case lv18
    case lv19
    case lv20
    
    var index: Int {
        return (SecretWords.allCases.firstIndex(of: self) ?? 0)
    }
    
    
    var wordsKey: String {
        return "com.secretWords"+String(describing: self)+".key"
    }
    
    var answersKey: String {
        return "com.secretWordsAnswer"+String(describing: self)+".key"
    }
    
    
    var words: [WordsModel] {
        if let data = UserDefaults.standard.data(forKey: wordsKey) {
            if let model = try? JSONDecoder().decode([WordsModel].self, from: data) {
                return model
            }
        }
        return defaultWords
       
    }
    
    func setWords(newValue: [WordsModel]) {
        if let data = try? JSONEncoder().encode(newValue) {
            UserDefaults.standard.set(data, forKey: wordsKey)
        }
    }
    
    
    var defaultWords: [WordsModel] {
        switch self {
        case .lv1:
            return [WordsModel(title: NSLocalizedString("secretWord.lv1.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv1.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv1.secret3", comment: ""), locked: true)]
        case .lv2:
            return [WordsModel(title: NSLocalizedString("secretWord.lv2.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv2.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv2.secret3", comment: ""), locked: true)]
        case .lv3:
            return [WordsModel(title: NSLocalizedString("secretWord.lv3.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv3.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv3.secret3", comment: ""), locked: true)]
        case .lv4:
            return [WordsModel(title: NSLocalizedString("secretWord.lv4.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv4.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv4.secret3", comment: ""), locked: true)]
        case .lv5:
            return [WordsModel(title: NSLocalizedString("secretWord.lv5.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv5.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv5.secret3", comment: ""), locked: true)]
        case .lv6:
            return [WordsModel(title: NSLocalizedString("secretWord.lv6.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv6.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv6.secret3", comment: ""), locked: true)]
        case .lv7:
            return [WordsModel(title: NSLocalizedString("secretWord.lv7.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv7.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv7.secret3", comment: ""), locked: true)]
        case .lv8:
            return [WordsModel(title: NSLocalizedString("secretWord.lv8.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv8.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv8.secret3", comment: ""), locked: true)]
        case .lv9:
            return [WordsModel(title: NSLocalizedString("secretWord.lv9.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv9.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv9.secret3", comment: ""), locked: true)]
        case .lv10:
            return [WordsModel(title: NSLocalizedString("secretWord.lv10.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv10.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv10.secret3", comment: ""), locked: true)]
        case .lv11:
            return [WordsModel(title: NSLocalizedString("secretWord.lv11.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv11.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv11.secret3", comment: ""), locked: true)]
        case .lv12:
            return [WordsModel(title: NSLocalizedString("secretWord.lv12.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv12.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv12.secret3", comment: ""), locked: true)]
        case .lv13:
            return [WordsModel(title: NSLocalizedString("secretWord.lv13.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv13.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv13.secret3", comment: ""), locked: true)]
        case .lv14:
            return [WordsModel(title: NSLocalizedString("secretWord.lv14.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv14.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv14.secret3", comment: ""), locked: true)]
        case .lv15:
            return [WordsModel(title: NSLocalizedString("secretWord.lv15.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv15.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv15.secret3", comment: ""), locked: true)]
        case .lv16:
            return [WordsModel(title: NSLocalizedString("secretWord.lv16.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv16.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv16.secret3", comment: ""), locked: true)]

        case .lv17:
            return [WordsModel(title: NSLocalizedString("secretWord.lv17.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv17.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv17.secret3", comment: ""), locked: true)]
        case .lv18:
            return [WordsModel(title: NSLocalizedString("secretWord.lv18.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv18.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv18.secret3", comment: ""), locked: true)]
        case .lv19:
            return [WordsModel(title: NSLocalizedString("secretWord.lv19.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv19.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv19.secret3", comment: ""), locked: true)]
        case .lv20:
            return [WordsModel(title: NSLocalizedString("secretWord.lv20.secret1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("secretWord.lv20.secret2", comment: ""), locked: true),
                    WordsModel(title: NSLocalizedString("secretWord.lv20.secret3", comment: ""), locked: true)]
//        case .lv20:
//            return 
        }
    }
    
    
    var answer: RelatedWordModel {
        if let data = UserDefaults.standard.data(forKey: answersKey) {
            if let model = try? JSONDecoder().decode(RelatedWordModel.self, from: data) {
                return model
            }
        }
        return defaultAnswer
    }
    
    func setAnswers(newValue: RelatedWordModel) {
        if let data = try? JSONEncoder().encode(newValue) {
            UserDefaults.standard.set(data, forKey: answersKey)
        }
    }
    
    
    var defaultAnswer: RelatedWordModel {
        switch self {
        case .lv1:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv1.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv1.relatedWord", comment: ""), guessed: false)
        case .lv2:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv2.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv2.relatedWord", comment: ""), guessed: false)
        case .lv3:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv3.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv3.relatedWord", comment: ""), guessed: false)
        case .lv4:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv4.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv4.relatedWord", comment: ""), guessed: false)
        case .lv5:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv5.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv5.relatedWord", comment: ""), guessed: false)
        case .lv6:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv6.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv6.relatedWord", comment: ""), guessed: false)
        case .lv7:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv7.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv7.relatedWord", comment: ""), guessed: false)
        case .lv8:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv8.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv8.relatedWord", comment: ""), guessed: false)
        case .lv9:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv9.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv9.relatedWord", comment: ""), guessed: false)
        case .lv10:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv10.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv10.relatedWord", comment: ""), guessed: false)
        case .lv11:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv11.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv11.relatedWord", comment: ""), guessed: false)
        case .lv12:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv12.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv12.relatedWord", comment: ""), guessed: false)
        case .lv13:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv13.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv13.relatedWord", comment: ""), guessed: false)
        case .lv14:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv14.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv14.relatedWord", comment: ""), guessed: false)
        case .lv15:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv15.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv15.relatedWord", comment: ""), guessed: false)
        case .lv16:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv16.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv16.relatedWord", comment: ""), guessed: false)
        case .lv17:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv17.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv17.relatedWord", comment: ""), guessed: false)
        case .lv18:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv18.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv18.relatedWord", comment: ""), guessed: false)
        case .lv19:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv19.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv19.relatedWord", comment: ""), guessed: false)
        case .lv20:
            return RelatedWordModel(answer: NSLocalizedString("secretWord.lv20.answer", comment: ""), relatedWords: NSLocalizedString("secretWord.lv20.relatedWord", comment: ""), guessed: false)
        }
    }
}
