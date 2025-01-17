//
//  String.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.10.2024.
//
//  guard !a.isEmpty && !b.isEmpty else {return 1000000000}

import UIKit
import NaturalLanguage

extension String {
    private func normalize() -> String {
        let tagger = NLTagger(tagSchemes: [.lemma])
        let str = self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        tagger.string = str
        var lemma = ""
        tagger.enumerateTags(in: str.startIndex..<str.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
            if let lemmaTag = tag?.rawValue {
                lemma += lemmaTag
            } else {
                lemma += str[tokenRange] // Fallback if no lemma found
            }
            return true
        }
        return lemma
    }

    // Function to calculate Levenshtein distance
    private func levenshteinDistance(_ a: String, _ b: String) -> Int {
        let aCount = a.count
        let bCount = b.count
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: bCount + 1), count: aCount + 1)

        for i in 0...aCount { matrix[i][0] = i }
        for j in 0...bCount { matrix[0][j] = j }

        for i in 1...aCount {
            for j in 1...bCount {
                if a[a.index(a.startIndex, offsetBy: i - 1)] == b[b.index(b.startIndex, offsetBy: j - 1)] {
                    matrix[i][j] = matrix[i - 1][j - 1]
                } else {
                    let deletion = matrix[i - 1][j] + 1
                    let insertion = matrix[i][j - 1] + 1
                    let substitution = matrix[i - 1][j - 1] + 1
                    matrix[i][j] = Swift.min(deletion, insertion, substitution)
                }
            }
        }
        return matrix[aCount][bCount]
    }

    // Check function to compare user answer with correct answer
    func compareString(word: String) -> Bool {
        guard self.count > 2, word.count > 2 else {
                   return self.lowercased() == word.lowercased()
        }
        let normalizedUserAnswer = self.normalize()
        let normalizedCorrectAnswer = word.normalize()
        guard normalizedUserAnswer.count > 2, normalizedCorrectAnswer.count > 2 else {
                   return normalizedUserAnswer == normalizedCorrectAnswer
        }
        let threshold = 2
        let distance = levenshteinDistance(normalizedUserAnswer, normalizedCorrectAnswer)
        if let cognates = areWordsCognates(self, word) {
            
            return  distance <= threshold && cognates
        } else {
            return distance <= 1
        }
        
    }
    
    
    func wordExistsWithNLLanguageRecognizer() -> Bool {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = self
       // let range = self.startIndex..<self.endIndex
        let tag = tagger.tag(at: self.startIndex, unit: .word, scheme: .lemma)
        return tag != nil  // If the tag is not nil, the word likely exists
    }
    
   
  

}

func areWordsCognates(_ word1: String, _ word2: String) -> Bool? {
    guard let embedding = NLEmbedding.wordEmbedding(for: .english) else {
        print("Word embeddings are not available for the specified language.")
        return false
    }

    // Step 1: Normalize words using lemmatization
    let lemma1 = normalizeWord(word1)
    let lemma2 = normalizeWord(word2)

    // If lemmatized forms are equal, the words are cognates
    if lemma1 == lemma2 {
        return true
    }

    // Step 2: Compute embeddings-based similarity
    guard
        let vector1 = embedding.vector(for: word1),
        let vector2 = embedding.vector(for: word2)
    else {
        print("One or both words are not in the embedding vocabulary.")
        return nil
    }

    let similarity = cosineSimilarity(vector1: vector1, vector2: vector2)

    // Adjust the threshold based on requirements
    return similarity > 0.7
}

func cosineSimilarity(vector1: [Double], vector2: [Double]) -> Double {
    let dotProduct = zip(vector1, vector2).map(*).reduce(0, +)
    let magnitude1 = sqrt(vector1.map { $0 * $0 }.reduce(0, +))
    let magnitude2 = sqrt(vector2.map { $0 * $0 }.reduce(0, +))
    return dotProduct / (magnitude1 * magnitude2)
}

func normalizeWord(_ word: String) -> String {
    let w = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    let tagger = NLTagger(tagSchemes: [.lemma])
    tagger.string = w//
    let range = w.startIndex..<w.endIndex
    return tagger.tag(at: w.startIndex, unit: .word, scheme: .lemma).0?.rawValue ?? w
   // return tagger.tag(at: word.startIndex, unit: .word, scheme: .lemma, tokenRange: nil).rawValue ?? word
}


