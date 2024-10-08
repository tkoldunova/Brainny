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
            return [WordsModel(title: "It’s not a painting, but you can see yourself in it", locked: false), WordsModel(title: "It shows the truth, but sometimes you wish to see a lie.", locked: true), WordsModel(title: "You face it every day, looking at it head-on.", locked: true)]
        case .lv2:
            return [WordsModel(title: "It's a thing that comes but never goes away", locked: false), WordsModel(title: "They are constantly looking at this", locked: true), WordsModel(title: "It is related to time.", locked: true)]
        case .lv3:
            return [WordsModel(title: "This is not a person, but it is always there", locked: false), WordsModel(title: "It may disappear, but it always comes back", locked: true), WordsModel(title: "It has no color, but it follows you", locked: true)]
        case .lv4:
            return [WordsModel(title: "It knows all the roads, but she can't walk", locked: false), WordsModel(title: "It is opened when the way is not known", locked: true), WordsModel(title: "It shows you where you are even if you don't know it.", locked: true)]
        case .lv5:
            return [WordsModel(title: "This needs to be trampled to make it better", locked: false), WordsModel(title: "It leads somewhere, but does not move itself", locked: true), WordsModel(title: "It leads where cars don't go.", locked: true)]
        case .lv6:
            return [WordsModel(title: "What moves us, but itself remains in place", locked: false), WordsModel(title: "You see its steps, but they disappear and appear again.", locked: true), WordsModel(title: "It appears where there are many people.", locked: true)]
        case .lv7:
            return [WordsModel(title: "You can keep it, but you can't see it.", locked: false), WordsModel(title: "It exists, but no one knows about it.", locked: true), WordsModel(title: "It is marked on calendars, but it lives in you.", locked: true)]
        case .lv8:
            return [WordsModel(title: "It can only increase.", locked: false), WordsModel(title: "He brings wisdom, but also leaves traces.", locked: true), WordsModel(title: "He lives in words that are not spoken.", locked: true)]
        case .lv9:
            return [WordsModel(title: "It is invisible, but its presence can be felt when it is broken", locked: false), WordsModel(title: "It's always in the wires, but you can't hold it in your hands.", locked: true), WordsModel(title: "Without it, devices are silent and rooms become dark.", locked: true)]
        case .lv10:
            return [WordsModel(title: "It's as light as a feather, yet even the most trained person can't hold it for long", locked: false), WordsModel(title: "It's invisible, but without it, you can't live for even a minute.", locked: true), WordsModel(title: "It can be slow and calm or fast and heavy.", locked: true)]
        case .lv11:
            return [WordsModel(title: "The more you take from it, the bigger it becomes", locked: false), WordsModel(title: "It is empty, but it can become a trap.", locked: true), WordsModel(title: "You can fall into it if you don't notice.", locked: true)]
        case .lv12:
            return [WordsModel(title: "There you can lift and move a horse and an elephant", locked: false), WordsModel(title: "Here everyone is moving forward, but the way back is impossible for everyone except one.", locked: true), WordsModel(title: "It's a battlefield, but without blood..", locked: true)]
        case .lv13:
            return [WordsModel(title: "The first two times it is given to us for free. The third time we have to pay.", locked: false), WordsModel(title: "Here everyone is moving forward, but the way back is impossible for everyone except one.", locked: true), WordsModel(title: "Their loss in childhood causes joy, but in adulthood - anxiety.", locked: true)]
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
            return RelatedWordModel(answer: "Mirror", relatedWords: "mirror", guessed: false)
        case .lv2:
            return RelatedWordModel(answer: "Clock", relatedWords: "clock, time", guessed: false)
        case .lv3:
            return RelatedWordModel(answer: "Shadow", relatedWords: "shadow", guessed: false)
        case .lv4:
            return RelatedWordModel(answer: "Map", relatedWords: "map, navigator, navigation", guessed: false)
        case .lv5:
            return RelatedWordModel(answer: "Footpath", relatedWords: "path, footpath", guessed: false)
        case .lv6:
            return RelatedWordModel(answer: "Escalator", relatedWords: "escalator, elevator", guessed: false)
        case .lv7:
            return RelatedWordModel(answer: "Secret", relatedWords: "secret, mystery", guessed: false)
        case .lv8:
            return RelatedWordModel(answer: "Age", relatedWords: "age, years old", guessed: false)
        case .lv9:
            return RelatedWordModel(answer: "Electricity", relatedWords: "electricity, electric", guessed: false)
        case .lv10:
            return RelatedWordModel(answer: "Breath", relatedWords: "breath", guessed: false)
        case .lv11:
            return RelatedWordModel(answer: "Pit", relatedWords: "pit", guessed: false)
        case .lv11:
            return RelatedWordModel(answer: "Chess", relatedWords: "pit", guessed: false)
        }
    }
}
