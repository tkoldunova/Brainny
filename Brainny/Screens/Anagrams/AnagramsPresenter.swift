//
//  GamePresenter.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit


protocol AnagramsView: AnyObject {
    func reload()
    func showTipView(type: TipType)
    func hideTipView()
    func showWinView()
    func setUpPointsLabel(count: Int, maxCount: Int)
    func setUpCoinsLabel(coins: Int)
    func showAlert()
}


protocol AnagramsPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource, TipViewDelegate, WinViewDelegate {
    init(view: AnagramsView, router: AnagramsRouterProtocol, interactor: AnagramsInteractorProtocol)
    func notifyWhenViewDidLoad()
    func getWold() -> String
    func checkIfWorldIsCorrect(word: String) -> Bool
}


class AnagramsPresenter: NSObject, AnagramsPresenterProtocol {
    weak var view: AnagramsView?
    private var router: AnagramsRouterProtocol
    private var interactor: AnagramsInteractorProtocol
    
    
    
    required init(view: AnagramsView, router: AnagramsRouterProtocol, interactor: AnagramsInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        super.init()
        
    }
    
    func notifyWhenViewDidLoad() {
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        let guessesWords = interactor.words.filter({$0.guessed})
        self.view?.setUpPointsLabel(count: guessesWords.count, maxCount: interactor.getDiv())
        
    }
    
    func checkIfWorldIsCorrect(word: String) -> Bool {
        let bool = interactor.checkIfWorldIsCorrent(word: word)
        let guessesWords = interactor.words.filter({$0.guessed})
        self.view?.setUpPointsLabel(count: guessesWords.count, maxCount: interactor.getDiv())
        if bool {
            AudioManager.shared.playCorrectSound()
        } else {
            AudioManager.shared.playWrongSound()
        }
        if interactor.checkWinResult() {
            
            var doneLevels = Games.annagrams.doneLevels
            if !doneLevels.contains(where: {$0.areEqual(to: interactor.anangram)}) {
                self.view?.showWinView()
                doneLevels.append(interactor.anangram)
                Games.annagrams.setDoneLevels(newValue: doneLevels)
            }

        }
        view?.reload()
        return bool
    }
    
    func getWold() -> String {
        return interactor.getWorld()
    }
    
    func tipHasChanged(_ tip: [String], answer: String, coins: Int) {
        self.interactor.coins = coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        if let ind = self.interactor.words.firstIndex(where: {$0.answer == answer}) {
            self.interactor.words[ind].setTip(tip)
        }
    }
    
    func unlockWord(word: String, coins: Int) {
        self.interactor.coins = coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
    }
    
    func openWord(answer: String, coins: Int) {
        self.interactor.coins = coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        let bool = interactor.checkIfWorldIsCorrent(word: answer)
        if bool {
            AudioManager.shared.playCorrectSound()
            let guessesWords = interactor.words.filter({$0.guessed})
            self.view?.setUpPointsLabel(count: guessesWords.count, maxCount: interactor.getDiv())
            self.view?.reload()
            if interactor.checkWinResult() {
                var doneLevels = Games.annagrams.doneLevels
                if !doneLevels.contains(where: {$0.areEqual(to: interactor.anangram)}) {
                    self.view?.showWinView()
                    doneLevels.append(interactor.anangram)
                    Games.annagrams.setDoneLevels(newValue: doneLevels)
                }

            }
        }
    }
    
    func showAlert() {
        self.view?.showAlert()
    }
    
    func hideWinView() {
        interactor.coins = UserDefaultsValues.coins
        self.view?.setUpCoinsLabel(coins: interactor.coins)
        self.router.dismiss()
    }
}

extension AnagramsPresenter: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "anagrams_cell", for: indexPath) as! AnagramsCollectionViewCell
            cell.configure(model:   interactor.words[indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let data =  interactor.words[indexPath.row]
            if !data.guessed {
                AudioManager.shared.playTouchedSound()
                self.view?.showTipView(type: .letter(TipLetterModel(tip: data.tip, answer: data.answer, price: 10, coins: interactor.coins)))
            }
        
    }
    
    
    
    
}
