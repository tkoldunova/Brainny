//
//  RelatedWords.swift
//  Brainny
//
//  Created by Tanya Koldunova on 24.09.2024.
//

import UIKit

struct WordsModel: Codable {
    var title: String
    var locked: Bool
    
//    init(title: String, locked: Bool) {
//        self.title = title
//        self.locked = locked
//    }
    
    mutating func setLocked(_ locked: Bool) {
        self.locked = locked
    }
}

struct RelatedWordModel: Codable {
    var answer: String
    var relatedWords: String
    var guessed: Bool
    var tip: [String?]
    
    init(answer: String, relatedWords: String, guessed: Bool) {
        self.answer = answer
        self.relatedWords = relatedWords
        self.guessed = guessed
        tip = Array(repeating: nil, count: answer.count)
    }
    
    init(answer: String, guessed: Bool) {
        self.answer = answer
        self.relatedWords = ""
        self.guessed = guessed
        tip = Array(repeating: nil, count: answer.count)
    }
    
    mutating func setGuessed(_ guessed: Bool) {
        self.guessed = guessed
    }
    
    mutating func setTip(_ tip: [String?]) {
        self.tip = tip
    }
}

enum RelatedWords: CaseIterable, LevelProtocol {
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
        return (RelatedWords.allCases.firstIndex(of: self) ?? 0)
    }
    
    
    var wordsKey: String {
        return "com.relatedWords1"+String(describing: self)+".key"
    }
    
    var answersKey: String {
        return "com.relatedWords1Answer"+String(describing: self)+".key"
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
            return [WordsModel(title: NSLocalizedString("relatedWords.lv1.word1", comment: ""), locked: false), 
                    WordsModel(title: NSLocalizedString("relatedWords.lv1.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv1.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv1.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv1.word5", comment: ""), locked: false)]
        case .lv2:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv2.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv2.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv2.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv2.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv2.word5", comment: ""), locked: false)]
        case .lv3:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv3.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv3.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv3.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv3.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv3.word5", comment: ""), locked: false)]
        case .lv4:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv4.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv4.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv4.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv4.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv4.word5", comment: ""), locked: false)]
        case .lv5:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv5.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv5.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv5.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv5.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv5.word5", comment: ""), locked: false)]
        case .lv6:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv6.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv6.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv6.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv6.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv6.word5", comment: ""), locked: false)]
        case .lv7:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv7.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv7.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv7.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv7.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv7.word5", comment: ""), locked: false)]
        case .lv8:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv8.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv8.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv8.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv8.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv8.word5", comment: ""), locked: false)]
        case .lv9:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv9.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv9.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv9.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv9.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv9.word5", comment: ""), locked: false)]
        case .lv10:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv10.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv10.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv10.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv10.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv10.word5", comment: ""), locked: false)]
        case .lv11:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv11.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv11.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv11.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv11.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv11.word5", comment: ""), locked: false)]
        case .lv12:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv12.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv12.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv12.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv12.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv12.word5", comment: ""), locked: false)]
        case .lv13:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv13.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv13.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv13.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv13.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv13.word5", comment: ""), locked: false)]
        case .lv14:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv14.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv14.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv14.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv14.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv14.word5", comment: ""), locked: false)]
        case .lv15:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv15.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv15.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv15.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv15.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv15.word5", comment: ""), locked: false)]
        case .lv16:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv16.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv16.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv16.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv16.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv16.word5", comment: ""), locked: false)]
        case .lv17:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv17.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv17.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv17.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv17.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv17.word5", comment: ""), locked: false)]
        case .lv18:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv18.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv18.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv18.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv18.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv18.word5", comment: ""), locked: false)]
        case .lv19:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv19.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv19.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv19.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv19.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv19.word5", comment: ""), locked: false)]
        case .lv20:
            return [WordsModel(title: NSLocalizedString("relatedWords.lv20.word1", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv20.word2", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv20.word3", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv20.word4", comment: ""), locked: false),
                    WordsModel(title: NSLocalizedString("relatedWords.lv20.word5", comment: ""), locked: false)]
        }
    }
    
    
    var answer: [RelatedWordModel] {
        if let data = UserDefaults.standard.data(forKey: answersKey) {
            if let model = try? JSONDecoder().decode([RelatedWordModel].self, from: data) {
                return model
            }
        }
        return defaultAnswer
    }
    
    func setAnswers(newValue: [RelatedWordModel]) {
        if let data = try? JSONEncoder().encode(newValue) {
            UserDefaults.standard.set(data, forKey: answersKey)
        }
    }
    
    
    var defaultAnswer: [RelatedWordModel] {
        switch self {
        case .lv1:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv1.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv1.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv1.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv1.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv1.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv1.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv1.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv1.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv1.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv1.relatedWord5", comment: ""), guessed: false),]
        case .lv2:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv2.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv2.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv2.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv2.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv2.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv2.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv2.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv2.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv2.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv2.relatedWord5", comment: ""), guessed: false),]
        case .lv3:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv3.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv3.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv3.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv3.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv3.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv3.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv3.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv3.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv3.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv3.relatedWord5", comment: ""), guessed: false),]
        case .lv4:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv4.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv4.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv4.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv4.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv4.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv4.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv4.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv4.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv4.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv4.relatedWord5", comment: ""), guessed: false),]
        case .lv5:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv5.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv5.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv5.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv5.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv5.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv5.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv5.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv5.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv5.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv5.relatedWord5", comment: ""), guessed: false),]
        case .lv6:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv6.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv6.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv6.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv6.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv6.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv6.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv6.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv6.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv6.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv6.relatedWord5", comment: ""), guessed: false),]
        case .lv7:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv7.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv7.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv7.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv7.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv7.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv7.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv7.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv7.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv7.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv7.relatedWord5", comment: ""), guessed: false),]
        case .lv8:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv8.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv8.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv8.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv8.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv8.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv8.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv8.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv8.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv8.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv8.relatedWord5", comment: ""), guessed: false),]
        case .lv9:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv9.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv9.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv9.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv9.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv9.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv9.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv9.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv9.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv9.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv9.relatedWord5", comment: ""), guessed: false),]
        case .lv10:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv10.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv10.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv10.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv10.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv10.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv10.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv10.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv10.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv10.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv10.relatedWord5", comment: ""), guessed: false),]
        case .lv11:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv11.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv11.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv11.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv11.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv11.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv11.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv11.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv11.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv11.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv11.relatedWord5", comment: ""), guessed: false),]
        case .lv12:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv12.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv12.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv12.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv12.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv12.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv12.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv12.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv12.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv12.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv12.relatedWord5", comment: ""), guessed: false),]
        case .lv13:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv13.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv13.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv13.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv13.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv13.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv13.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv13.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv13.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv13.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv13.relatedWord5", comment: ""), guessed: false),]
        case .lv14:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv14.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv14.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv14.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv14.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv14.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv14.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv14.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv14.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv14.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv14.relatedWord5", comment: ""), guessed: false),]
        case .lv15:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv15.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv15.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv15.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv15.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv15.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv15.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv15.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv15.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv15.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv15.relatedWord5", comment: ""), guessed: false),]
        case .lv16:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv16.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv16.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv16.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv16.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv16.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv16.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv16.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv16.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv16.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv16.relatedWord5", comment: ""), guessed: false),]
        case .lv17:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv17.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv17.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv17.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv17.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv17.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv17.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv17.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv17.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv17.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv17.relatedWord5", comment: ""), guessed: false),]
        case .lv18:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv18.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv18.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv18.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv18.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv18.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv18.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv18.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv18.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv18.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv18.relatedWord5", comment: ""), guessed: false),]
        case .lv19:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv19.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv19.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv19.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv19.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv19.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv19.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv19.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv19.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv19.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv19.relatedWord5", comment: ""), guessed: false),]
        case .lv20:
            return [RelatedWordModel(answer: NSLocalizedString("relatedWords.lv20.answer1", comment: "") , relatedWords: NSLocalizedString("relatedWords.lv20.relatedWord1", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv20.answer2", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv20.relatedWord2", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv20.answer3", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv20.relatedWord3", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv20.answer4", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv20.relatedWord4", comment: ""), guessed: false),
                    RelatedWordModel(answer: NSLocalizedString("relatedWords.lv15.answer5", comment: ""), relatedWords: NSLocalizedString("relatedWords.lv20.relatedWord5", comment: ""), guessed: false),]
        }
    }
    
    
}
