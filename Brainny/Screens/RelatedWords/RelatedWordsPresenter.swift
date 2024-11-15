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
    func setTextFieldEmpty()
    func showWinView()
    func setUpCoinsLabel(coins: Int)
    func showAlert()
}

protocol RelatedWordsPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, TipViewDelegate, WinViewDelegate {
    init(view: RelatedWordsViewProtocol, interactor: RelatedWordsInteractorProtocol, router: RelatedWordsRouterProtocol)
    func checkValue() 
    func notifyWhenViewDidLoad()
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
    
    func notifyWhenViewDidLoad() {
        self.view?.setUpCoinsLabel(coins: interactor.coins)
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
                var relatedWordsArray = interactor.answers[i].relatedWords.components(separatedBy: ", ")
                relatedWordsArray = relatedWordsArray.filter({$0.compareString(word: refacoredSuggestion)})
                if !relatedWordsArray.isEmpty {
                    interactor.answers[i].setGuessed(true) //= interactor.answers[i].s answer
                    findedInd = i
                }
            }
            if let findedInd = findedInd {
                AudioManager.shared.playCorrectSound()
                guard let cell = view?.getCell(indexPath: IndexPath(row: findedInd, section: 0)) as? RelatedWordsTableViewCell else {return}
                cell.guessed(model: interactor.answers[findedInd])
            } else {
                AudioManager.shared.playWrongSound()
                self.view?.shakeTextField()
            }
            self.view?.setTextFieldEmpty()
            self.interactor.suggestion = nil
            self.checkQuessedCount()
            
        }
    }
    
    func tipHasChanged(_ tip: [String], answer: String, coins: Int) {
        interactor.coins = coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        if let ind = self.interactor.answers.firstIndex(where: {$0.answer == answer}) {
            interactor.answers[ind].setTip(tip)
        }
    }
    
    func unlockWord(word: String, coins: Int) {
        interactor.coins = coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        if let ind = self.interactor.words.firstIndex(where: {$0.title == word}) {
            interactor.words[ind].setLocked(false)
        }
        self.view?.reloadWordsData()
    }
    
    func openWord(answer: String, coins: Int) {
        interactor.coins = coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        if let ind = self.interactor.answers.firstIndex(where: {$0.answer == answer}) {
            AudioManager.shared.playCorrectSound()
            interactor.answers[ind].setGuessed(true)
            checkQuessedCount()
            guard let cell = view?.getCell(indexPath: IndexPath(row: ind, section: 0)) as? RelatedWordsTableViewCell else {return}
            cell.guessed(model: interactor.answers[ind])
        }
    }
    
    func showAlert() {
        self.view?.showAlert()
    }
    
    func checkQuessedCount() {
        let allGuessed = interactor.answers.allSatisfy({$0.guessed == true})
        if allGuessed {
            self.view?.showWinView()
            var doneLevels = Games.relatedWords.doneLevels
            if !doneLevels.contains(where: {$0.areEqual(to: interactor.model)}) {
                doneLevels.append(interactor.model)
                Games.relatedWords.setDoneLevels(newValue: doneLevels)
            }
        }
    }
    
    func hideWinView() {
        interactor.coins = UserDefaultsValues.coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        self.router.dismiss()
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
            AudioManager.shared.playTouchedSound()
            self.view?.showTipView(type: .word(TipWordModel(title: NSLocalizedString("tip.word.title2", comment: ""), price: 15, word: interactor.words[indexPath.row].title, coins: interactor.coins)))
        }
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           if kScrollDirectionIsHorizontal {
//               return CGSize(width: 60, height: CGFloat(Int.random(in: 60..<180)))
//           } else {
//               return CGSize(width: CGFloat(Int.random(in: 60..<180)), height: 60)
//           }
//       }
    
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
            AudioManager.shared.playTouchedSound()
            self.view?.showTipView(type: .letter(TipLetterModel(tip: interactor.answers[indexPath.row].tip, answer: interactor.answers[indexPath.row].answer, price: 10, coins: interactor.coins)))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}




