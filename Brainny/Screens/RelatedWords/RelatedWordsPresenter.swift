//
//  RelatedWordsPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 23.09.2024.
//

import UIKit

protocol RelatedWordsViewProtocol: AnyObject {
    func shakeTextField()
    func getCell(indexPath: IndexPath) -> UITableViewCell?
    func showTipView(type: TipType)
    func reloadWordsData()
}

protocol RelatedWordsPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, TipViewDelegate {
    init(view: RelatedWordsViewProtocol, interactor: RelatedWordsInteractorProtocol, router: RelatedWordsRouterProtocol)
    func checkValue() 
}

final class RelatedWordsPresenter: NSObject, RelatedWordsPresenterProtocol {
    
    weak var view: RelatedWordsViewProtocol?
    var interactor: RelatedWordsInteractorProtocol
    var router: RelatedWordsRouterProtocol
    
    required init(view: RelatedWordsViewProtocol, interactor: RelatedWordsInteractorProtocol, router: RelatedWordsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.checkValue()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        interactor.suggestion = textField.text
    }
    
    
    func checkValue() {
        if let suggestion = interactor.suggestion {
            var findedInd: Int?
            for i in 0 ..< interactor.answers.count {
                let refacoredSuggestion = suggestion.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                if interactor.answers[i].relatedWords.contains(refacoredSuggestion) {
                    interactor.answers[i].setGuessed(true) //= interactor.answers[i].s answer
                    findedInd = i
                }
            }
            if let findedInd = findedInd {
                guard let cell = view?.getCell(indexPath: IndexPath(row: findedInd, section: 0)) as? RelatedWordsTableViewCell else {return}
                cell.guessed(model: interactor.answers[findedInd])
            } else {
                self.view?.shakeTextField()
            }
        }
    }
    
    func tipHasChanged(_ tip: [String?], answer: String) {
        if let ind = self.interactor.answers.firstIndex(where: {$0.answer == answer}) {
            interactor.answers[ind].setTip(tip)
        }
    }
    
    func unlockWord(word: String) {
        if let ind = self.interactor.words.firstIndex(where: {$0.title == word}) {
            interactor.words[ind].setLocked(false)
        }
        self.view?.reloadWordsData()
    }
    
    func openWord(answer: String) {
        if let ind = self.interactor.answers.firstIndex(where: {$0.answer == answer}) {
            interactor.answers[ind].setGuessed(true)
            guard let cell = view?.getCell(indexPath: IndexPath(row: ind, section: 0)) as? RelatedWordsTableViewCell else {return}
            cell.guessed(model: interactor.answers[ind])
        }
    }
    
}

extension RelatedWordsPresenter {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "words", for: indexPath) as? RelatedWordsCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(model: interactor.words[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if interactor.words[indexPath.row].locked {
            self.view?.showTipView(type: .word(TipWordModel(title: "Unlock word", price: 15, word: interactor.words[indexPath.row].title)))
        }
    }
    
}

extension RelatedWordsPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "words", for: indexPath) as? RelatedWordsTableViewCell else {return UITableViewCell()}
        cell.configure(model: interactor.answers[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !interactor.answers[indexPath.row].guessed {
            self.view?.showTipView(type: .letter(TipLetterModel(tip: interactor.answers[indexPath.row].tip, answer: interactor.answers[indexPath.row].answer, price: 10)))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}




