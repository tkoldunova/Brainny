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
        switch self {
        case .lv1:
            return [
                WordsModel(key: "secretWord.lv1.secret1", locked: false),
                WordsModel(key: "secretWord.lv1.secret2", locked: true),
                WordsModel(key: "secretWord.lv1.secret3", locked: true),
            ]
        case .lv2:
            return [
                WordsModel(key: "secretWord.lv2.secret1", locked: false),
                WordsModel(key: "secretWord.lv2.secret2", locked: true),
                WordsModel(key: "secretWord.lv2.secret3", locked: true),
            ]
        case .lv3:
            return [
                WordsModel(key: "secretWord.lv3.secret1", locked: false),
                WordsModel(key: "secretWord.lv3.secret2", locked: true),
                WordsModel(key: "secretWord.lv3.secret3", locked: true),
            ]
        case .lv4:
            return [
                WordsModel(key: "secretWord.lv4.secret1", locked: false),
                WordsModel(key: "secretWord.lv4.secret2", locked: true),
                WordsModel(key: "secretWord.lv4.secret3", locked: true),
            ]
        case .lv5:
            return [
                WordsModel(key: "secretWord.lv5.secret1", locked: false),
                WordsModel(key: "secretWord.lv5.secret2", locked: true),
                WordsModel(key: "secretWord.lv5.secret3", locked: true),
            ]
        case .lv6:
            return [
                WordsModel(key: "secretWord.lv6.secret1", locked: false),
                WordsModel(key: "secretWord.lv6.secret2", locked: true),
                WordsModel(key: "secretWord.lv6.secret3", locked: true),
            ]
        case .lv7:
            return [
                WordsModel(key: "secretWord.lv7.secret1", locked: false),
                WordsModel(key: "secretWord.lv7.secret2", locked: true),
                WordsModel(key: "secretWord.lv7.secret3", locked: true),
            ]
        case .lv8:
            return [
                WordsModel(key: "secretWord.lv8.secret1", locked: false),
                WordsModel(key: "secretWord.lv8.secret2", locked: true),
                WordsModel(key: "secretWord.lv8.secret3", locked: true),
            ]
        case .lv9:
            return [
                WordsModel(key: "secretWord.lv9.secret1", locked: false),
                WordsModel(key: "secretWord.lv9.secret2", locked: true),
                WordsModel(key: "secretWord.lv9.secret3", locked: true),
            ]
        case .lv10:
            return [
                WordsModel(key: "secretWord.lv10.secret1", locked: false),
                WordsModel(key: "secretWord.lv10.secret2", locked: true),
                WordsModel(key: "secretWord.lv10.secret3", locked: true),
            ]
        case .lv11:
            return [
                WordsModel(key: "secretWord.lv11.secret1", locked: false),
                WordsModel(key: "secretWord.lv11.secret2", locked: true),
                WordsModel(key: "secretWord.lv11.secret3", locked: true),
            ]
        case .lv12:
            return [
                WordsModel(key: "secretWord.lv12.secret1", locked: false),
                WordsModel(key: "secretWord.lv12.secret2", locked: true),
                WordsModel(key: "secretWord.lv12.secret3", locked: true),
            ]
        case .lv13:
            return [
                WordsModel(key: "secretWord.lv13.secret1", locked: false),
                WordsModel(key: "secretWord.lv13.secret2", locked: true),
                WordsModel(key: "secretWord.lv13.secret3", locked: true),
            ]
        case .lv14:
            return [
                WordsModel(key: "secretWord.lv14.secret1", locked: false),
                WordsModel(key: "secretWord.lv14.secret2", locked: true),
                WordsModel(key: "secretWord.lv14.secret3", locked: true),
            ]
        case .lv15:
            return [
                WordsModel(key: "secretWord.lv15.secret1", locked: false),
                WordsModel(key: "secretWord.lv15.secret2", locked: true),
                WordsModel(key: "secretWord.lv15.secret3", locked: true),
            ]
        case .lv16:
            return [
                WordsModel(key: "secretWord.lv16.secret1", locked: false),
                WordsModel(key: "secretWord.lv16.secret2", locked: true),
                WordsModel(key: "secretWord.lv16.secret3", locked: true),
            ]
        case .lv17:
            return [
                WordsModel(key: "secretWord.lv17.secret1", locked: false),
                WordsModel(key: "secretWord.lv17.secret2", locked: true),
                WordsModel(key: "secretWord.lv17.secret3", locked: true),
            ]
        case .lv18:
            return [
                WordsModel(key: "secretWord.lv18.secret1", locked: false),
                WordsModel(key: "secretWord.lv18.secret2", locked: true),
                WordsModel(key: "secretWord.lv18.secret3", locked: true),
            ]
        case .lv19:
            return [
                WordsModel(key: "secretWord.lv19.secret1", locked: false),
                WordsModel(key: "secretWord.lv19.secret2", locked: true),
                WordsModel(key: "secretWord.lv19.secret3", locked: true),
            ]
        case .lv20:
            return [
                WordsModel(key: "secretWord.lv20.secret1", locked: false),
                WordsModel(key: "secretWord.lv20.secret2", locked: true),
                WordsModel(key: "secretWord.lv20.secret3", locked: true),
            ]
        }
    }

    
    var answer: RelatedWordModel {
        switch self {
        case .lv1:
            return RelatedWordModel(answerKey: "secretWord.lv1.answer", relatedWordsKey: "secretWord.lv1.relatedWord")
        case .lv2:
            return RelatedWordModel(answerKey: "secretWord.lv2.answer", relatedWordsKey: "secretWord.lv2.relatedWord")
        case .lv3:
            return RelatedWordModel(answerKey: "secretWord.lv3.answer", relatedWordsKey: "secretWord.lv3.relatedWord")
        case .lv4:
            return RelatedWordModel(answerKey: "secretWord.lv4.answer", relatedWordsKey: "secretWord.lv4.relatedWord")
        case .lv5:
            return RelatedWordModel(answerKey: "secretWord.lv5.answer", relatedWordsKey: "secretWord.lv5.relatedWord")
        case .lv6:
            return RelatedWordModel(answerKey: "secretWord.lv6.answer", relatedWordsKey: "secretWord.lv6.relatedWord")
        case .lv7:
            return RelatedWordModel(answerKey: "secretWord.lv7.answer", relatedWordsKey: "secretWord.lv7.relatedWord")
        case .lv8:
            return RelatedWordModel(answerKey: "secretWord.lv8.answer", relatedWordsKey: "secretWord.lv8.relatedWord")
        case .lv9:
            return RelatedWordModel(answerKey: "secretWord.lv9.answer", relatedWordsKey: "secretWord.lv9.relatedWord")
        case .lv10:
            return RelatedWordModel(answerKey: "secretWord.lv10.answer", relatedWordsKey: "secretWord.lv10.relatedWord")
        case .lv11:
            return RelatedWordModel(answerKey: "secretWord.lv11.answer", relatedWordsKey: "secretWord.lv11.relatedWord")
        case .lv12:
            return RelatedWordModel(answerKey: "secretWord.lv12.answer", relatedWordsKey: "secretWord.lv12.relatedWord")
        case .lv13:
            return RelatedWordModel(answerKey: "secretWord.lv13.answer", relatedWordsKey: "secretWord.lv13.relatedWord")
        case .lv14:
            return RelatedWordModel(answerKey: "secretWord.lv14.answer", relatedWordsKey: "secretWord.lv14.relatedWord")
        case .lv15:
            return RelatedWordModel(answerKey: "secretWord.lv15.answer", relatedWordsKey: "secretWord.lv15.relatedWord")
        case .lv16:
            return RelatedWordModel(answerKey: "secretWord.lv16.answer", relatedWordsKey: "secretWord.lv16.relatedWord")
        case .lv17:
            return RelatedWordModel(answerKey: "secretWord.lv17.answer", relatedWordsKey: "secretWord.lv17.relatedWord")
        case .lv18:
            return RelatedWordModel(answerKey: "secretWord.lv18.answer", relatedWordsKey: "secretWord.lv18.relatedWord")
        case .lv19:
            return RelatedWordModel(answerKey: "secretWord.lv19.answer", relatedWordsKey: "secretWord.lv19.relatedWord")
        case .lv20:
            return RelatedWordModel(answerKey: "secretWord.lv20.answer", relatedWordsKey: "secretWord.lv20.relatedWord")
        }
    }
}
