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
    private func normalize(_ text: String) -> String {
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = text.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var lemma = ""
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma) { tag, tokenRange in
            if let lemmaTag = tag?.rawValue {
                lemma += lemmaTag
            } else {
                lemma += text[tokenRange] // Fallback if no lemma found
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
        let normalizedUserAnswer = normalize(self)
        let normalizedCorrectAnswer = normalize(word)
        guard normalizedUserAnswer.count > 2, normalizedCorrectAnswer.count > 2 else {
                   return normalizedUserAnswer == normalizedCorrectAnswer
        }
        let threshold = 2
        let distance = levenshteinDistance(normalizedUserAnswer, normalizedCorrectAnswer)
        return distance <= threshold
    }
}
