//
//  SecretWordsPresenter.swift
//  Brainny
//
//  Created by Tanya Koldunova on 30.09.2024.
//

import UIKit
protocol SecretWordsViewProtocol: AnyObject {
    func shakeTextField()
    func setAnswerView(answer: RelatedWordModel)
    func setAnswerQuessed(answer: RelatedWordModel)
    func showTipView(type: TipType)
    func showWinView()
    func reloadWordsData()
    func setUpCoinsLabel(coins: Int)
    func showAlert()
    func setTextFieldEmpty()
}

protocol SecretWordsPresenterProtocol: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, TipViewDelegate, WinViewDelegate {
    init(view: SecretWordsViewProtocol, interactor: SecretWordsInteractorProtocol, router: SecretWordsRouterProtocol)
    func notifyWhenViewDidLoad()
    func openTipForAnswer()
    func checkValue()
}

final class SecretWordsPresenter: NSObject, SecretWordsPresenterProtocol {

    
    
    weak var view: SecretWordsViewProtocol?
    var interactor: SecretWordsInteractorProtocol
    var router: SecretWordsRouterProtocol
    
    required init(view: SecretWordsViewProtocol, interactor: SecretWordsInteractorProtocol, router: SecretWordsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func notifyWhenViewDidLoad() {
        self.view?.setAnswerView(answer: interactor.answer)
        self.view?.setUpCoinsLabel(coins: interactor.coins)
    }
    
    func openTipForAnswer() {
        if !interactor.answer.guessed {
            self.view?.showTipView(type: .letter(TipLetterModel(tip: interactor.answer.tip, answer: interactor.answer.answer, price: 10, coins: interactor.coins)))
        }
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
            let refacoredSuggestion = suggestion.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            if interactor.answer.relatedWords.contains(refacoredSuggestion) {
                AudioManager.shared.playCorrectSound()
                interactor.answer.setGuessed(true) //= interactor.answers[i].s answer
                self.view?.setAnswerQuessed(answer: interactor.answer)
                self.checkQuessedCount()
            } else {
                AudioManager.shared.playWrongSound()
                self.view?.shakeTextField()
            }
        }
        self.view?.setTextFieldEmpty()
        self.interactor.suggestion = nil

    }
    
    func tipHasChanged(_ tip: [String], answer: String, coins: Int) {
        if self.interactor.answer.answer == answer {
            interactor.coins = coins
            self.view?.setUpCoinsLabel(coins: interactor.coins)
            interactor.answer.setTip(tip)
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
        if self.interactor.answer.answer == answer {
            interactor.coins = coins
            self.view?.setUpCoinsLabel(coins: interactor.coins)
            AudioManager.shared.playCorrectSound()
            interactor.answer.setGuessed(true)
            self.checkQuessedCount()
            self.view?.setAnswerQuessed(answer: interactor.answer)
        }
    }
    
    func showAlert() {
        self.view?.showAlert()
    }
    
    func checkQuessedCount() {
        if interactor.answer.guessed {
            var doneLevels = Games.secretWords.doneLevels
            if !doneLevels.contains(where: {$0.areEqual(to: interactor.model)}) {
                self.view?.showWinView()
                doneLevels.append(interactor.model)
                Games.secretWords.setDoneLevels(newValue: doneLevels)
            }
        }
    }
    
    func hideWinView() {
        interactor.coins = UserDefaultsValues.coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        self.router.dismiss()
    }
    
}

extension SecretWordsPresenter {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "secret words", for: indexPath) as? SecretWordTableViewCell else {return UITableViewCell()}
        cell.configure(model: interactor.words[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if interactor.words[indexPath.row].locked {
            AudioManager.shared.playTouchedSound()
            self.view?.showTipView(type: .word(TipWordModel(title: NSLocalizedString("tip.word.title3", comment: ""), price: 15, word: interactor.words[indexPath.row].title, coins: interactor.coins)))
        }
    }
}

