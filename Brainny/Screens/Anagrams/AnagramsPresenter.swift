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

}


protocol AnagramsPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource, TipViewDelegate {
    init(view: AnagramsView, router: AnagramsRouterProtocol, interactor: AnagramsInteractorProtocol)
    
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
        interactor.getWorlds { str in
            self.view?.reload()
        }
    }
    
    func checkIfWorldIsCorrect(word: String) -> Bool {
        let bool = interactor.checkIfWorldIsCorrent(word: word)
        view?.reload()
        if bool {
            AudioManager.shared.playCorrectSound()
        } else {
            AudioManager.shared.playWrongSound()
        }
        return bool
    }
    
    func getWold() -> String {
        return interactor.getWorld()
    }
    
    func tipHasChanged(_ tip: [String?], answer: String) {
        if let ind = self.interactor.words?.firstIndex(where: {$0.answer == answer}) {
            self.interactor.words?[ind].setTip(tip)
        }
    }
    
    func unlockWord(word: String) {}
    
    func openWord(answer: String) {
        if let ind = self.interactor.words?.firstIndex(where: {$0.answer == answer}) {
            AudioManager.shared.playCorrectSound()
            self.interactor.words?[ind].setGuessed(true)
            if let m = interactor.words?[ind] {
                self.interactor.moveToTop(word: m)
            }
            view?.reload()
        }
    }
    
    func dismiss() {
        self.router.dismiss()
    }
}

extension AnagramsPresenter: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.words?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "anagrams_cell", for: indexPath) as! AnagramsCollectionViewCell
        if let data =  interactor.words?[indexPath.row] {
            cell.configure(model: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data =  interactor.words?[indexPath.row] {
            if !data.guessed {
                AudioManager.shared.playTouchedSound()
                self.view?.showTipView(type: .letter(TipLetterModel(tip: data.tip, answer: data.answer, price: 10)))
            }
        }
    }
    
    
    
    
}
