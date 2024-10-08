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
            
            return [WordsModel(title: "Pencil", locked: false), WordsModel(title: "Brush", locked: false), WordsModel(title: "Canvas", locked: false), WordsModel(title: "Gallery", locked: false), WordsModel(title: "Style", locked: false)]
        case .lv2:
            return [WordsModel(title: "Grape", locked: false), WordsModel(title: "Сhardonnay", locked: false), WordsModel(title: "Glass", locked: false), WordsModel(title: "Degustation", locked: false), WordsModel(title: "style", locked: false)]
        case .lv3:
            return [WordsModel]()
        case .lv4:
            return [WordsModel]()
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
            return [RelatedWordModel(answer: "Drawing", relatedWords: "drawing, illustration, depiction, draft, picture, landscape, painting", guessed: false), RelatedWordModel(answer: "Painter", relatedWords: "master, painter, art creator, illustrator", guessed: false), RelatedWordModel(answer: "Art", relatedWords: "сreation, сraftsmanship, mastery, craft, creativity, talant, artword", guessed: false), RelatedWordModel(answer: "Exhibition", relatedWords: "art installation, vernissage, еxhibit, auction", guessed: false), RelatedWordModel(answer: "Design", relatedWords: "designer, design, architect, architecture", guessed: false),]
        case .lv2:
            return [RelatedWordModel(answer: "Wine", relatedWords: "wine", guessed: false), RelatedWordModel(answer: "Winery", relatedWords: "winery", guessed: false), RelatedWordModel(answer: "Barrel", relatedWords: "barrel, cock", guessed: false), RelatedWordModel(answer: "Sort", relatedWords: "sort, aging,", guessed: false), RelatedWordModel(answer: "Sommelier", relatedWords: "sommelier,", guessed: false)]
        case .lv3:
            return [RelatedWordModel]()
        case .lv4:
            return [RelatedWordModel]()
        }
    }
}
