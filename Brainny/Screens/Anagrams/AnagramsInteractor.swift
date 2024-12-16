//
//  GameInteractor.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit


protocol AnagramsInteractorProtocol: AnyObject {
    var anangram: AnagramModel {get}
    var words: [RelatedWordModel] { get set }
    var coins: Int {get set}
    func getWorld() -> String
    func getDiv()->Int
    func checkIfWorldIsCorrent(word: String) -> Bool
    func checkWinResult()->Bool 
  //  func checkifWorldidAvailable(world: String) -> Bool
    func moveToTop(word: RelatedWordModel)
}


class AnagramsInteractor: AnagramsInteractorProtocol {
   
    var anangram: AnagramModel
    var correctWords = [String]()
    var words: [RelatedWordModel] {
        didSet {
        }
    }
    var coins: Int {
        didSet {
            UserDefaultsValues.coins = coins
        }
    }
    
    init(anangram: AnagramModel) {
        self.anangram = anangram
        self.coins = UserDefaultsValues.coins
        self.words = anangram.words
        self.words.sort(by: {$0.guessDate ?? Date.distantPast > $1.guessDate ?? Date.distantPast})
    }
    
    
    func checkIfWorldIsCorrent(word: String) -> Bool {
        if  let worldModel = words.first(where: {$0.answer == word}) {
            if !worldModel.guessed {
                if let ind = self.words.firstIndex(where: {$0.answer == word}) {
                    self.words[ind].setGuessed(true)
                }
                words.sort(by: {$0.guessDate ?? Date.distantPast > $1.guessDate ?? Date.distantPast})
                return true
            } else {
                return false
            }
        } else {
            return false
        }
        
    }
    
    func moveToTop(word: RelatedWordModel) {
        self.words.removeAll(where: {$0.answer == word.answer})
        self.words.insert(word, at: 0)
    }
    
    func checkWinResult()->Bool {
        let count = self.words.filter({$0.guessed}).count
        return count >= getDiv()
    }
    
    func getDiv()->Int {
        let count = self.words.count
        if count > 140 {
            return 60
        } else if count > 100 {
            return 50
        } else if count > 70 {
            return 40
        } else if count > 40 {
            return 30
        } else {
            return count
        }
        
    }

    
    
    func generatePermutations(_ characters: [Character], current: String, results: inout Set<String>) {
           if current.count >= 3 {
               results.insert(current)
           }
           for i in 0..<characters.count {
               var newChars = characters
               let char = newChars.remove(at: i)
               generatePermutations(newChars, current: current + String(char), results: &results)
           }
       }

       func getAllStrings(characters: [Character]) -> Set<String> {
           var results = Set<String>()
           generatePermutations(characters, current: "", results: &results)
           return results.filter { $0.count <= 6 }
       }

    func getWorld() -> String {
        return anangram.world
    }
  
    
    private func isCorrect(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: NSLocalizedString("anagrams.languageCode", comment: ""))
        return misspelledRange.location == NSNotFound
    }
    
}



//struct WordsModel: Codable {
//    var title: String
//    var locked: Bool
//    
////    init(title: String, locked: Bool) {
////        self.title = title
////        self.locked = locked
////    }
//    
//    mutating func setLocked(_ locked: Bool) {
//        self.locked = locked
//    }
//}



enum AnagramModel: CaseIterable, LevelProtocol {
    
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
    case lv21
    case lv22
    case lv23
    case lv24
    case lv25
    case lv26
    case lv27
    case lv28
    case lv29
    case lv30
    
    
    var world: String {
        switch self {
        case .lv1:
           return NSLocalizedString("anagrams.lv1.world", comment: "")
        case .lv2:
            return NSLocalizedString("anagrams.lv2.world", comment: "")
        case .lv3:
            return NSLocalizedString("anagrams.lv3.world", comment: "")
        case .lv4:
            return NSLocalizedString("anagrams.lv4.world", comment: "")
        case .lv5:
            return NSLocalizedString("anagrams.lv5.world", comment: "")
        case .lv6:
            return NSLocalizedString("anagrams.lv6.world", comment: "")
        case .lv7:
            return NSLocalizedString("anagrams.lv7.world", comment: "")
        case .lv8:
            return NSLocalizedString("anagrams.lv8.world", comment: "")
        case .lv9:
            return NSLocalizedString("anagrams.lv9.world", comment: "")
        case .lv10:
            return NSLocalizedString("anagrams.lv10.world", comment: "")
        case .lv11:
            return NSLocalizedString("anagrams.lv11.world", comment: "")
        case .lv12:
            return NSLocalizedString("anagrams.lv12.world", comment: "")
        case .lv13:
            return NSLocalizedString("anagrams.lv13.world", comment: "")
        case .lv14:
            return NSLocalizedString("anagrams.lv14.world", comment: "")
        case .lv15:
            return NSLocalizedString("anagrams.lv15.world", comment: "")
        case .lv16:
            return NSLocalizedString("anagrams.lv16.world", comment: "")
        case .lv17:
            return NSLocalizedString("anagrams.lv17.world", comment: "")
        case .lv18:
            return NSLocalizedString("anagrams.lv18.world", comment: "")
        case .lv19:
            return NSLocalizedString("anagrams.lv19.world", comment: "")
        case .lv20:
            return NSLocalizedString("anagrams.lv20.world", comment: "")
        case .lv21:
            return NSLocalizedString("anagrams.lv21.world", comment: "")
        case .lv22:
            return NSLocalizedString("anagrams.lv22.world", comment: "")
        case .lv23:
            return NSLocalizedString("anagrams.lv23.world", comment: "")
        case .lv24:
            return NSLocalizedString("anagrams.lv24.world", comment: "")
        case .lv25:
            return NSLocalizedString("anagrams.lv25.world", comment: "")
        case .lv26:
            return NSLocalizedString("anagrams.lv26.world", comment: "")
        case .lv27:
            return NSLocalizedString("anagrams.lv27.world", comment: "")
        case .lv28:
            return NSLocalizedString("anagrams.lv28.world", comment: "")
        case .lv29:
            return NSLocalizedString("anagrams.lv29.world", comment: "")
        case .lv30:
            return NSLocalizedString("anagrams.lv30.world", comment: "")
        }
    }
    
    
    var wordsKey: String {
        switch self {
        case .lv1:
            return "anagrams.lv1.answers"
        case .lv2:
            return "anagrams.lv2.answers"
        case .lv3:
            return "anagrams.lv3.answers"
        case .lv4:
            return "anagrams.lv4.answers"
        case .lv5:
            return "anagrams.lv5.answers"
        case .lv6:
            return "anagrams.lv6.answers"
        case .lv7:
            return "anagrams.lv7.answers"
        case .lv8:
            return "anagrams.lv8.answers"
        case .lv9:
            return "anagrams.lv9.answers"
        case .lv10:
            return "anagrams.lv10.answers"
        case .lv11:
            return "anagrams.lv11.answers"
        case .lv12:
            return "anagrams.lv12.answers"
        case .lv13:
            return "anagrams.lv13.answers"
        case .lv14:
            return "anagrams.lv14.answers"
        case .lv15:
            return "anagrams.lv15.answers"
        case .lv16:
            return "anagrams.lv16.answers"
        case .lv17:
            return "anagrams.lv17.answers"
        case .lv18:
            return "anagrams.lv18.answers"
        case .lv19:
            return "anagrams.lv19.answers"
        case .lv20:
            return "anagrams.lv20.answers"
        case .lv21:
            return "anagrams.lv21.answers"
        case .lv22:
            return "anagrams.lv22.answers"
        case .lv23:
            return "anagrams.lv23.answers"
        case .lv24:
            return "anagrams.lv24.answers"
        case .lv25:
            return "anagrams.lv25.answers"
        case .lv26:
            return "anagrams.lv26.answers"
        case .lv27:
            return "anagrams.lv27.answers"
        case .lv28:
            return "anagrams.lv28.answers"
        case .lv29:
            return "anagrams.lv29.answers"
        case .lv30:
            return "anagrams.lv30.answers"
        }
    }
    
    var index: Int {
            return (AnagramModel.allCases.firstIndex(of: self) ?? 0)
        }

    
    var words: [RelatedWordModel] {
          if let data = UserDefaults.standard.data(forKey: wordsKey) {
              if let model = try? JSONDecoder().decode([RelatedWordModel].self, from: data) {
                  return model
              }
          }
        let array = NSLocalizedString(wordsKey, comment: "").components(separatedBy: ", ")
  //      return array.map({RelatedWordModel(answer: $0, guessed: false, saveInDefaults: false)})
        return array.map({RelatedWordModel(answer: $0)})
         
      }
      
      func setWords(newValue: [RelatedWordModel]) {
          if let data = try? JSONEncoder().encode(newValue) {
              UserDefaults.standard.set(data, forKey: wordsKey)
          }
      }
    
    
    

    
}


//protocol LevelProtocol: Codable {
//    var index: Int {get}
//}
//
//extension LevelProtocol {
//    func areEqual(to rhs: any LevelProtocol) -> Bool {
//        return self.index == rhs.index && type(of: self) == type(of: rhs)
//    }
//
//}


