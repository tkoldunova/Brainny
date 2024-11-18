//
//  GameInteractor.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit


protocol AnagramsInteractorProtocol: AnyObject {
    var anangram: AnagramModel {get}
    var words: [RelatedWordModel]? { get set }
    var coins: Int {get set}
    func getWorld() -> String
    func getWorlds(completion: @escaping([RelatedWordModel]) -> Void)
    func checkIfWorldIsCorrent(word: String) -> Bool
    func checkWinResult()->Bool 
  //  func checkifWorldidAvailable(world: String) -> Bool
    func moveToTop(word: RelatedWordModel)
}


class AnagramsInteractor: AnagramsInteractorProtocol {
    
    var anangram: AnagramModel
    var correctWords = [String]()
    var words: [RelatedWordModel]? {
        didSet {
            guard let words = words else { return }
            anangram.setWords(newValue: words)
        }
    }
    var coins: Int
    
    init(anangram: AnagramModel) {
        self.anangram = anangram
        self.coins = UserDefaultsValues.coins
    }
    
    
    func checkIfWorldIsCorrent(word: String) -> Bool {
        guard words != nil else { return false }
        if isCorrect(word: word) {
            
            let worldModel = words!.first(where: {$0.answer == word})!
            if !worldModel.guessed {
//                self.words?.removeAll(where: {$0 == worldModel})
                self.words?.removeAll(where: {$0.answer == word})
                self.words?.insert(RelatedWordModel(answer: word, guessed: true), at: 0)
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func moveToTop(word: RelatedWordModel) {
        self.words?.removeAll(where: {$0.answer == word.answer})
        self.words?.insert(word, at: 0)
    }
    
    func checkWinResult()->Bool {
        let count = self.words?.filter({$0.guessed}).count ?? 0
        return count > (self.words?.count ?? 0)/2
    }
    
    func getWorlds(completion: @escaping([RelatedWordModel]) -> Void) {
        guard anangram.words.isEmpty else {
            words = anangram.words
            completion(self.words!)
            return
        }
            DispatchQueue.global().async {
                                
                let allPermutations = self.getAllStrings(characters: Array(self.anangram.world))
                
                var arr = [String]()
                allPermutations.forEach({ permutation in
                    if self.isCorrect(word: permutation) {
                        arr.append(permutation)
                    }
                })
                let sorter = arr.sorted(by: {$0.count <= $1.count})
                self.words = sorter.map({RelatedWordModel(answer: $0, guessed: false)})
                completion(self.words!)
            }
        }
    
    
    func generatePermutations(_ characters: [Character], current: String, results: inout Set<String>) {
           // Add the current string if it meets the length requirements
           if current.count >= 3 {
               results.insert(current)
           }

           // Generate permutations by adding each character
           for i in 0..<characters.count {
               var newChars = characters
               let char = newChars.remove(at: i)
               generatePermutations(newChars, current: current + String(char), results: &results)
           }
       }

       func getAllStrings(characters: [Character]) -> Set<String> {
           var results = Set<String>()

           // Generate permutations for all lengths from 3 to 6
           generatePermutations(characters, current: "", results: &results)
           
           // Filter results to only include strings with a maximum length of 6
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
    
    var index: Int {
            return (AnagramModel.allCases.firstIndex(of: self) ?? 0)
        }
    
    var wordsKey: String {
            return "com.anagrams"+String(describing: self)+".key"
        }
    
    
    var words: [RelatedWordModel] {
          if let data = UserDefaults.standard.data(forKey: wordsKey) {
              if let model = try? JSONDecoder().decode([RelatedWordModel].self, from: data) {
                  return model
              }
          }
          return []
         
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


