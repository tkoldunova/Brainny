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
    private var key: String
    
    init(title: String, locked: Bool) {
        self.title = title
        self.key = "com."+title+".key"
        self.locked = UserDefaults.standard.bool(forKey: "com."+title+".key")//locked
        UserDefaults.standard.setValue(locked, forKey: "com."+title+".key")
    }
    
    init(title: String) {
        self.title = title
        self.key = "com."+title+".key"
        self.locked = UserDefaults.standard.bool(forKey: "com."+title+".key")
    }
    
    init(key: String) {
        self.title = NSLocalizedString(key, comment: "")
        self.key = "com."+key+"word.key"
        self.locked = UserDefaults.standard.bool(forKey: self.key)
    }
    
    init(key: String, locked: Bool) {
        self.title = NSLocalizedString(key, comment: "")
        self.key = "com."+key+"word.key"
        UserDefaults.standard.register(defaults: [self.key:locked])
        self.locked = UserDefaults.standard.bool(forKey: self.key)
    }
    
    
    mutating func setLocked(_ locked: Bool) {
        self.locked = locked
        UserDefaults.standard.setValue(locked, forKey: self.key)
    }
    
    
}

struct RelatedWordModel: Codable {
    var answer: String
    var relatedWords: String
    var guessed: Bool
    var tip: [String]
    var guessDate: Date?
    private var guessedKey: String
    private var tipKey: String
    private var dateKey: String
    private var saveInDefaults: Bool
    
    init(answer: String, relatedWords: String, guessed: Bool, saveInDefaults: Bool) {
        self.saveInDefaults = saveInDefaults
        self.answer = answer
        self.relatedWords = relatedWords
        self.guessedKey =  "com."+answer+"guessed.key"
        self.tipKey = "com."+answer+"tip.key"
        self.dateKey = "com."+answer+"date.key"
        if !saveInDefaults {
            self.guessed = guessed
            self.tip = Array(repeating: "", count: answer.count)
        } else {
            UserDefaults.standard.set(guessed, forKey:  "com."+answer+"guessed.key")
            self.guessed = UserDefaults.standard.bool(forKey: "com."+answer+"guessed.key")//guessed
            self.tip = UserDefaults.standard.array(forKey: "com."+answer+"tip.key") as? [String] ?? Array(repeating: "", count: answer.count)
            self.guessDate = UserDefaults.standard.object(forKey: "com."+answer+"date.key") as? Date
        }
    }
    
    init(answer: String, guessed: Bool, saveInDefaults: Bool) {
        self.saveInDefaults = saveInDefaults
        self.answer = answer
        self.relatedWords = ""
        self.guessedKey =  "com."+answer+"guessed.key"
        self.tipKey = "com."+answer+"tip.key"
        self.dateKey = "com."+answer+"date.key"
        if saveInDefaults {
            UserDefaults.standard.set(guessed, forKey:  "com."+answer+"guessed.key")
            self.guessed = UserDefaults.standard.bool(forKey: "com."+answer+"guessed.key")//guessed
            self.tip = UserDefaults.standard.array(forKey: "com."+answer+"tip.key") as? [String] ?? Array(repeating: "", count: answer.count)
            self.guessDate = UserDefaults.standard.object(forKey: "com."+answer+"date.key") as? Date
        } else {
            self.guessed = guessed
            self.tip = Array(repeating: "", count: answer.count)

        }
    }
    
    init(answerKey: String, relatedWordsKey: String) {
        self.saveInDefaults = true
        self.answer = NSLocalizedString(answerKey, comment: "")
        self.relatedWords = NSLocalizedString(relatedWordsKey, comment: "")
        self.guessedKey =  "com."+answerKey+"answer.key"
        self.tipKey = "com."+answerKey+"tip.key"
        self.dateKey = "com."+answerKey+"date.key"
        self.guessed = UserDefaults.standard.bool(forKey: guessedKey)//guessed
        self.tip = UserDefaults.standard.array(forKey: tipKey) as? [String] ?? Array(repeating: "", count: answer.count)
        self.guessDate = UserDefaults.standard.object(forKey: "com."+answer+"date.key") as? Date
    }
    
    init(answer: String, relatedWordsKey: String = "") {
        self.saveInDefaults = true
        self.answer = answer
        self.relatedWords = relatedWordsKey
        self.guessedKey =  "com."+answer+"answer.key"
        self.tipKey = "com."+answer+"tip.key"
        self.dateKey = "com."+answer+"date.key"
        self.guessed = UserDefaults.standard.bool(forKey: guessedKey)//guessed
        self.tip = UserDefaults.standard.array(forKey: tipKey) as? [String] ?? Array(repeating: "", count: answer.count)
        self.guessDate = UserDefaults.standard.object(forKey: "com."+answer+"date.key") as? Date
    }
    
    mutating func setGuessed(_ guessed: Bool) {
        self.guessed = guessed
        self.guessDate = Date()
        UserDefaults.standard.set(guessDate, forKey: dateKey)//object(forKey: "com."+answer+"date.key") as? Date
        if saveInDefaults {
            UserDefaults.standard.setValue(guessed, forKey: guessedKey)
        }
       
    }
    
    mutating func setTip(_ tip: [String]) {
        self.tip = tip
        if saveInDefaults {
            UserDefaults.standard.setValue(tip, forKey: tipKey)
        }
        
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
        switch self {
        case .lv1:
            return [
                WordsModel(key: "relatedWords.lv1.word1"),
                WordsModel(key: "relatedWords.lv1.word2"),
                WordsModel(key: "relatedWords.lv1.word3"),
                WordsModel(key: "relatedWords.lv1.word4"),
                WordsModel(key: "relatedWords.lv1.word5")
            ]
        case .lv2:
            return [
                WordsModel(key: "relatedWords.lv2.word1"),
                WordsModel(key: "relatedWords.lv2.word2"),
                WordsModel(key: "relatedWords.lv2.word3"),
                WordsModel(key: "relatedWords.lv2.word4",locked: true),
                WordsModel(key: "relatedWords.lv2.word5",locked: true)
            ]
        case .lv3:
            return [
                WordsModel(key: "relatedWords.lv3.word1"),
                WordsModel(key: "relatedWords.lv3.word2"),
                WordsModel(key: "relatedWords.lv3.word3"),
                WordsModel(key: "relatedWords.lv3.word4",locked: true),
                WordsModel(key: "relatedWords.lv3.word5",locked: true)
            ]
        case .lv4:
            return [
                WordsModel(key: "relatedWords.lv4.word1"),
                WordsModel(key: "relatedWords.lv4.word2"),
                WordsModel(key: "relatedWords.lv4.word3"),
                WordsModel(key: "relatedWords.lv4.word4",locked: true),
                WordsModel(key: "relatedWords.lv4.word5",locked: true)
            ]
        case .lv5:
            return [
                WordsModel(key: "relatedWords.lv5.word1"),
                WordsModel(key: "relatedWords.lv5.word2"),
                WordsModel(key: "relatedWords.lv5.word3"),
                WordsModel(key: "relatedWords.lv5.word4"),
                WordsModel(key: "relatedWords.lv5.word5")
            ]
          
        case .lv6:
            return [
                WordsModel(key: "relatedWords.lv6.word1"),
                WordsModel(key: "relatedWords.lv6.word2"),
                WordsModel(key: "relatedWords.lv6.word3"),
                WordsModel(key: "relatedWords.lv6.word4"),
                WordsModel(key: "relatedWords.lv6.word5")
            ]
        case .lv7:
            return [
                WordsModel(key: "relatedWords.lv7.word1"),
                WordsModel(key: "relatedWords.lv7.word2"),
                WordsModel(key: "relatedWords.lv7.word3"),
                WordsModel(key: "relatedWords.lv7.word4"),
                WordsModel(key: "relatedWords.lv7.word5")
            ]
        case .lv8:
            return [
                WordsModel(key: "relatedWords.lv8.word1"),
                WordsModel(key: "relatedWords.lv8.word2"),
                WordsModel(key: "relatedWords.lv8.word3"),
                WordsModel(key: "relatedWords.lv8.word4"),
                WordsModel(key: "relatedWords.lv8.word5")
            ]
        case .lv9:
            return [
                WordsModel(key: "relatedWords.lv9.word1"),
                WordsModel(key: "relatedWords.lv9.word2"),
                WordsModel(key: "relatedWords.lv9.word3"),
                WordsModel(key: "relatedWords.lv9.word4"),
                WordsModel(key: "relatedWords.lv9.word5")
            ]
        case .lv10:
            return [
                WordsModel(key: "relatedWords.lv10.word1"),
                WordsModel(key: "relatedWords.lv10.word2"),
                WordsModel(key: "relatedWords.lv10.word3"),
                WordsModel(key: "relatedWords.lv10.word4"),
                WordsModel(key: "relatedWords.lv10.word5")
            ]
        case .lv11:
            return [
                WordsModel(key: "relatedWords.lv11.word1"),
                WordsModel(key: "relatedWords.lv11.word2"),
                WordsModel(key: "relatedWords.lv11.word3"),
                WordsModel(key: "relatedWords.lv11.word4"),
                WordsModel(key: "relatedWords.lv11.word5")
            ]
        case .lv12:
            return [
                WordsModel(key: "relatedWords.lv12.word1"),
                WordsModel(key: "relatedWords.lv12.word2"),
                WordsModel(key: "relatedWords.lv12.word3"),
                WordsModel(key: "relatedWords.lv12.word4"),
                WordsModel(key: "relatedWords.lv12.word5")
            ]
        case .lv13:
            return [
                WordsModel(key: "relatedWords.lv13.word1"),
                WordsModel(key: "relatedWords.lv13.word2"),
                WordsModel(key: "relatedWords.lv13.word3"),
                WordsModel(key: "relatedWords.lv13.word4"),
                WordsModel(key: "relatedWords.lv13.word5")
            ]
        case .lv14:
            return [
                WordsModel(key: "relatedWords.lv14.word1"),
                WordsModel(key: "relatedWords.lv14.word2"),
                WordsModel(key: "relatedWords.lv14.word3"),
                WordsModel(key: "relatedWords.lv14.word4"),
                WordsModel(key: "relatedWords.lv14.word5")
            ]
        case .lv15:
            return [
                WordsModel(key: "relatedWords.lv15.word1"),
                WordsModel(key: "relatedWords.lv15.word2"),
                WordsModel(key: "relatedWords.lv15.word3"),
                WordsModel(key: "relatedWords.lv15.word4"),
                WordsModel(key: "relatedWords.lv15.word5")
            ]
        case .lv16:
            return [
                WordsModel(key: "relatedWords.lv16.word1"),
                WordsModel(key: "relatedWords.lv16.word2"),
                WordsModel(key: "relatedWords.lv16.word3"),
                WordsModel(key: "relatedWords.lv16.word4"),
                WordsModel(key: "relatedWords.lv16.word5")
            ]
        case .lv17:
            return [
                WordsModel(key: "relatedWords.lv17.word1"),
                WordsModel(key: "relatedWords.lv17.word2"),
                WordsModel(key: "relatedWords.lv17.word3"),
                WordsModel(key: "relatedWords.lv17.word4"),
                WordsModel(key: "relatedWords.lv17.word5")
            ]
        case .lv18:
            return [
                WordsModel(key: "relatedWords.lv18.word1"),
                WordsModel(key: "relatedWords.lv18.word2"),
                WordsModel(key: "relatedWords.lv18.word3"),
                WordsModel(key: "relatedWords.lv18.word4"),
                WordsModel(key: "relatedWords.lv18.word5")
            ]
        case .lv19:
            return [
                WordsModel(key: "relatedWords.lv19.word1"),
                WordsModel(key: "relatedWords.lv19.word2"),
                WordsModel(key: "relatedWords.lv19.word3"),
                WordsModel(key: "relatedWords.lv19.word4"),
                WordsModel(key: "relatedWords.lv19.word5")
            ]
        case .lv20:
            return [
                WordsModel(key: "relatedWords.lv20.word1"),
                WordsModel(key: "relatedWords.lv20.word2"),
                WordsModel(key: "relatedWords.lv20.word3"),
                WordsModel(key: "relatedWords.lv20.word4"),
                WordsModel(key: "relatedWords.lv20.word5")
            ]
        }
    }

    var answer: [RelatedWordModel] {
        switch self {
        case .lv1:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv1.answer1", relatedWordsKey: "relatedWords.lv1.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv1.answer2", relatedWordsKey: "relatedWords.lv1.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv1.answer3", relatedWordsKey: "relatedWords.lv1.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv1.answer4", relatedWordsKey: "relatedWords.lv1.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv1.answer5", relatedWordsKey: "relatedWords.lv1.relatedWord5"),
            ]
            
        case .lv2:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv2.answer1", relatedWordsKey: "relatedWords.lv2.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv2.answer2", relatedWordsKey: "relatedWords.lv2.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv2.answer3", relatedWordsKey: "relatedWords.lv2.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv2.answer4", relatedWordsKey: "relatedWords.lv2.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv2.answer5", relatedWordsKey: "relatedWords.lv2.relatedWord5"),
            ]
        case .lv3:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv3.answer1", relatedWordsKey: "relatedWords.lv3.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv3.answer2", relatedWordsKey: "relatedWords.lv3.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv3.answer3", relatedWordsKey: "relatedWords.lv3.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv3.answer4", relatedWordsKey: "relatedWords.lv3.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv3.answer5", relatedWordsKey: "relatedWords.lv3.relatedWord5"),
            ]
        case .lv4:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv4.answer1", relatedWordsKey: "relatedWords.lv4.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv4.answer2", relatedWordsKey: "relatedWords.lv4.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv4.answer3", relatedWordsKey: "relatedWords.lv4.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv4.answer4", relatedWordsKey: "relatedWords.lv4.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv4.answer5", relatedWordsKey: "relatedWords.lv4.relatedWord5"),
            ]
        case .lv5:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv5.answer1", relatedWordsKey: "relatedWords.lv5.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv5.answer2", relatedWordsKey: "relatedWords.lv5.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv5.answer3", relatedWordsKey: "relatedWords.lv5.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv5.answer4", relatedWordsKey: "relatedWords.lv5.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv5.answer5", relatedWordsKey: "relatedWords.lv5.relatedWord5"),
            ]
        case .lv6:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv6.answer1", relatedWordsKey: "relatedWords.lv6.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv6.answer2", relatedWordsKey: "relatedWords.lv6.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv6.answer3", relatedWordsKey: "relatedWords.lv6.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv6.answer4", relatedWordsKey: "relatedWords.lv6.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv6.answer5", relatedWordsKey: "relatedWords.lv6.relatedWord5"),
            ]
        case .lv7:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv7.answer1", relatedWordsKey: "relatedWords.lv7.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv7.answer2", relatedWordsKey: "relatedWords.lv7.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv7.answer3", relatedWordsKey: "relatedWords.lv7.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv7.answer4", relatedWordsKey: "relatedWords.lv7.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv7.answer5", relatedWordsKey: "relatedWords.lv7.relatedWord5"),
            ]
        case .lv8:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv8.answer1", relatedWordsKey: "relatedWords.lv8.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv8.answer2", relatedWordsKey: "relatedWords.lv8.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv8.answer3", relatedWordsKey: "relatedWords.lv8.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv8.answer4", relatedWordsKey: "relatedWords.lv8.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv8.answer5", relatedWordsKey: "relatedWords.lv8.relatedWord5"),

            ]
        case .lv9:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv9.answer1", relatedWordsKey: "relatedWords.lv9.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv9.answer2", relatedWordsKey: "relatedWords.lv9.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv9.answer3", relatedWordsKey: "relatedWords.lv9.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv9.answer4", relatedWordsKey: "relatedWords.lv9.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv9.answer5", relatedWordsKey: "relatedWords.lv9.relatedWord5"),
            ]
        case .lv10:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv10.answer1", relatedWordsKey: "relatedWords.lv10.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv10.answer2", relatedWordsKey: "relatedWords.lv10.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv10.answer3", relatedWordsKey: "relatedWords.lv10.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv10.answer4", relatedWordsKey: "relatedWords.lv10.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv10.answer5", relatedWordsKey: "relatedWords.lv10.relatedWord5"),
            ]
        case .lv11:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv11.answer1", relatedWordsKey: "relatedWords.lv11.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv11.answer2", relatedWordsKey: "relatedWords.lv11.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv11.answer3", relatedWordsKey: "relatedWords.lv11.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv11.answer4", relatedWordsKey: "relatedWords.lv11.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv11.answer5", relatedWordsKey: "relatedWords.lv11.relatedWord5"),
            ]
        case .lv12:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv12.answer1", relatedWordsKey: "relatedWords.lv12.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv12.answer2", relatedWordsKey: "relatedWords.lv12.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv12.answer3", relatedWordsKey: "relatedWords.lv12.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv12.answer4", relatedWordsKey: "relatedWords.lv12.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv12.answer5", relatedWordsKey: "relatedWords.lv12.relatedWord5"),
            ]
        case .lv13:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv13.answer1", relatedWordsKey: "relatedWords.lv13.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv13.answer2", relatedWordsKey: "relatedWords.lv13.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv13.answer3", relatedWordsKey: "relatedWords.lv13.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv13.answer4", relatedWordsKey: "relatedWords.lv13.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv13.answer5", relatedWordsKey: "relatedWords.lv13.relatedWord5"),
            ]
        case .lv14:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv14.answer1", relatedWordsKey: "relatedWords.lv14.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv14.answer2", relatedWordsKey: "relatedWords.lv14.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv14.answer3", relatedWordsKey: "relatedWords.lv14.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv14.answer4", relatedWordsKey: "relatedWords.lv14.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv14.answer5", relatedWordsKey: "relatedWords.lv14.relatedWord5"),

            ]
        case .lv15:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv15.answer1", relatedWordsKey: "relatedWords.lv15.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv15.answer2", relatedWordsKey: "relatedWords.lv15.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv15.answer3", relatedWordsKey: "relatedWords.lv15.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv15.answer4", relatedWordsKey: "relatedWords.lv15.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv15.answer5", relatedWordsKey: "relatedWords.lv15.relatedWord5"),

            ]
        case .lv16:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv16.answer1", relatedWordsKey: "relatedWords.lv16.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv16.answer2", relatedWordsKey: "relatedWords.lv16.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv16.answer3", relatedWordsKey: "relatedWords.lv16.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv16.answer4", relatedWordsKey: "relatedWords.lv16.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv16.answer5", relatedWordsKey: "relatedWords.lv16.relatedWord5"),

            ]
        case .lv17:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv17.answer1", relatedWordsKey: "relatedWords.lv17.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv17.answer2", relatedWordsKey: "relatedWords.lv17.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv17.answer3", relatedWordsKey: "relatedWords.lv17.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv17.answer4", relatedWordsKey: "relatedWords.lv17.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv17.answer5", relatedWordsKey: "relatedWords.lv17.relatedWord5"),
            ]
        case .lv18:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv18.answer1", relatedWordsKey: "relatedWords.lv18.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv18.answer2", relatedWordsKey: "relatedWords.lv18.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv18.answer3", relatedWordsKey: "relatedWords.lv18.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv18.answer4", relatedWordsKey: "relatedWords.lv18.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv18.answer5", relatedWordsKey: "relatedWords.lv18.relatedWord5"),
            ]
        case .lv19:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv19.answer1", relatedWordsKey: "relatedWords.lv19.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv19.answer2", relatedWordsKey: "relatedWords.lv19.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv19.answer3", relatedWordsKey: "relatedWords.lv19.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv19.answer4", relatedWordsKey: "relatedWords.lv19.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv19.answer5", relatedWordsKey: "relatedWords.lv19.relatedWord5"),
            ]
        case .lv20:
            return [
                RelatedWordModel(answerKey: "relatedWords.lv20.answer1", relatedWordsKey: "relatedWords.lv20.relatedWord1"),
                RelatedWordModel(answerKey: "relatedWords.lv20.answer2", relatedWordsKey: "relatedWords.lv20.relatedWord2"),
                RelatedWordModel(answerKey: "relatedWords.lv20.answer3", relatedWordsKey: "relatedWords.lv20.relatedWord3"),
                RelatedWordModel(answerKey: "relatedWords.lv20.answer4", relatedWordsKey: "relatedWords.lv20.relatedWord4"),
                RelatedWordModel(answerKey: "relatedWords.lv20.answer5", relatedWordsKey: "relatedWords.lv20.relatedWord5"),
            ]
        }
    }
    
    
}
