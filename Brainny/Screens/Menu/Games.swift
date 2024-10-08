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
            return "Related Words"
        case .annagrams:
            return "Annagrams"
        case .secretWords:
            return "Secret Words"
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
       
    }
    
    var model: [LevelProtocol] {
        switch self {
        case .relatedWords:
            return RelatedWords.allCases
        case .annagrams:
            return [any LevelProtocol]()
        case .secretWords:
            return [any LevelProtocol]()
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
                return [any LevelProtocol]()
            case .secretWords:
                return [any LevelProtocol]()
            }
        }
        return [any LevelProtocol]()
    }
    
    private func setLevelValue(newValue: [LevelProtocol], key: String)  {
        switch self {
        case .relatedWords:
            guard let newValue = newValue as? [RelatedWords] else {return}
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        case .annagrams:
            return
        case .secretWords:
            return
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

