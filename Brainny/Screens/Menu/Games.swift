//
//  Games.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

enum Games: Int, CaseIterable {
    case relatedWords = 0
    case annagrams = 1
    case secretWords = 2
    
    var title: String {
        switch self {
        case .relatedWords:
            return NSLocalizedString("relatedWords.title", comment: "")
        case .annagrams:
            return NSLocalizedString("anagrams.title", comment: "")
        case .secretWords:
            return NSLocalizedString("secretWord.title", comment: "")
        }
    }
    
    var availableKey: String {
        return "com."+String(describing: self)+"available.key"
    }
    
    var doneKey : String {
        return "com."+String(describing: self)+"done.key"
    }
    
    
    var availableLevels: [LevelProtocol] {
       return getLevelValue(with: availableKey)
    }
    
    func setAvailableLevels(newValue: [LevelProtocol])  {
       setLevelValue(newValue: newValue, key: availableKey)
       
    }
    
    var doneLevels: [LevelProtocol] {
       return getLevelValue(with: doneKey)
    }
    
    func setDoneLevels(newValue: [LevelProtocol])  {
       setLevelValue(newValue: newValue, key: doneKey)
        if newValue.count%2==0 {
            let endIndex = (availableLevels.count + 4 < model.count) ? availableLevels.count + 4 : model.count
            let newAvailable = Array(model[availableLevels.count..<endIndex])
            var available = availableLevels
            available.append(contentsOf: newAvailable)
            setAvailableLevels(newValue: available)
        }
    }
    
    func setDefaultData() {
        switch self {
        case .relatedWords:
            let model = Array(RelatedWords.allCases.prefix(4))
            if let data = try? JSONEncoder().encode(model) {
                UserDefaults.standard.register(defaults: [availableKey : data])
            }
        case .annagrams:
            let model = Array(AnagramModel.allCases.prefix(4))
            if let data = try? JSONEncoder().encode(model) {
                UserDefaults.standard.register(defaults: [availableKey : data])
            }
        case .secretWords:
            let model = Array(SecretWords.allCases.prefix(4))
            if let data = try? JSONEncoder().encode(model) {
                UserDefaults.standard.register(defaults: [availableKey : data])
            }
        }
    }
    
    var model: [LevelProtocol] {
        switch self {
        case .relatedWords:
            return RelatedWords.allCases
        case .annagrams:
            return AnagramModel.allCases
        case .secretWords:
            return SecretWords.allCases
        }
    }
    
    
    private func getLevelValue(with key: String) -> [LevelProtocol] {
        if let data = UserDefaults.standard.data(forKey: key) {
            switch self {
            case .relatedWords:
                if let model = try? JSONDecoder().decode([RelatedWords].self, from: data) {
                    return model
                }
            case .annagrams:
//                if let model = try? JSONDecoder().decode([AnagramModel].self, from: data) {
//                    return model
//                }
                return AnagramModel.allCases
            case .secretWords:
                if let model = try? JSONDecoder().decode([SecretWords].self, from: data) {
                    return model
                }
            }
        }
        return [any LevelProtocol]()
    }
    
    private func setLevelValue(newValue: [LevelProtocol], key: String)  {
        switch self {
        case .relatedWords:
            guard let newValue = newValue as? [RelatedWords] else {return}
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            }
        case .annagrams:
            guard let newValue = newValue as? [AnagramModel] else {return}
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            }
        case .secretWords:
            guard let newValue = newValue as? [SecretWords] else {return}
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    
}


protocol LevelProtocol: Codable {
    var index: Int {get}
    
}

extension LevelProtocol {
    func areEqual(to rhs: any LevelProtocol) -> Bool {
        return self.index == rhs.index && type(of: self) == type(of: rhs)
    }

}

