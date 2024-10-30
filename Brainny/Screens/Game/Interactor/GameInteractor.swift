//
//  GameInteractor.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit


protocol GameInteractorProtocol: AnyObject {
    func getWorlds(completion: @escaping([WordsModel]) -> Void)
    func checkIfWorldIsCorrent(word: String) -> Bool
    func checkifWorldidAvailable(world: String) -> Bool
    var words: [WordsModel]? { get }
    
    func getWorld() -> String
}


class GameInteractor: GameInteractorProtocol {
   
    
    
//    var words: [String]?
    
    
    
    var anangram: AnagramModel
    
    var correctWords = [String]()
    
    var words: [WordsModel]? {
        didSet {
            guard let words = words else { return }
            anangram.setWords(newValue: words)
        }
    }
    
    init(anangram: AnagramModel) {
        self.anangram = anangram
    }
    
    
    func checkIfWorldIsCorrent(word: String) -> Bool {
        guard words != nil else { return false }
        if isCorrect(word: word) {
            self.words?.removeAll(where: {$0.title == word})
            
            self.words?.insert(WordsModel(title: word, locked: false), at: 0)
            return true
        } else {
            return false
        }
    }
    
    func checkifWorldidAvailable(world: String) -> Bool  {
        
        let bool = correctWords.contains(world)
        
        return bool
        
        
    }
    
    func getWorlds(completion: @escaping([WordsModel]) -> Void) {
        guard anangram.words.isEmpty else {
            words = anangram.words
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
                self.words = sorter.map({WordsModel(title: $0, locked: true)})
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
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "ru")
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
    
    case lvl1
    case lvl2
    case lvl3
    case lvl4
    case lvl5
    case lvl6
    case lvl7
    case lvl8
    case lvl9
    case lvl10
    case lvl11
    case lvl12
    case lvl13
    case lvl14
    case lvl15
    case lvl16
    case lvl17
    case lvl18
    case lvl19
    case lvl20
    case lvl21
    case lvl22
    case lvl23
    case lvl24
    case lvl25
    case lvl26
    case lvl27
    case lvl28
    case lvl29
    case lvl30
    
    
    var world: String {
        switch self {
        case .lvl1:
           return "картон"
        case .lvl2:
            return "гврмония"
        case .lvl3:
            return "ракета"
        case .lvl4:
            return "красота"
        case .lvl5:
            return "лимонад"
        case .lvl6:
            return "черника"
        case .lvl7:
            return "фонарик"
        case .lvl8:
            return "зеркало"
        case .lvl9:
            return "фисташка"
        case .lvl10:
            return "дизайнер"
        case .lvl11:
            return "русалка"
        case .lvl12:
            return "давление"
        case .lvl13:
            return  "корабль"
        case .lvl14:
            return "завтрак"
        case .lvl15:
            return "котлета"
        case .lvl16:
            return "формула"
        case .lvl17:
            return "шкатулка"
        case .lvl18:
            return "защитник"
        case .lvl19:
            return "стрела"
        case .lvl20:
            return "мелодия"
        case .lvl21:
            return "сорока"
        case .lvl22:
            return "ворона"
        case .lvl23:
            return "молния"
        case .lvl24:
            return  "кабина"
        case .lvl25:
            return "морковь"
        case .lvl26:
            return "теннис"
        case .lvl27:
            return "звезда"
        case .lvl28:
            return "голова"
        case .lvl29:
            return "железо"
        case .lvl30:
            return "жираф"
        }
    }
    
    var index: Int {
            return (AnagramModel.allCases.firstIndex(of: self) ?? 0)
        }
    
    var wordsKey: String {
            return "com.anagrams"+String(describing: self)+".key"
        }
    
    
    var words: [WordsModel] {
          if let data = UserDefaults.standard.data(forKey: wordsKey) {
              if let model = try? JSONDecoder().decode([WordsModel].self, from: data) {
                  return model
              }
          }
          return []
         
      }
      
      func setWords(newValue: [WordsModel]) {
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


