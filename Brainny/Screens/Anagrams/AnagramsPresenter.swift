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


protocol AnagramsPresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource {
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
        return bool
    }
    
    func getWold() -> String {
        return interactor.getWorld()
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
//        if let data =  interactor.words?[indexPath.row] {
//            if data.locked {
//                self.view?.showTipView(type: .letter(TipLetterModel(tip: <#T##[String?]#>, answer: <#T##String#>, price: <#T##Int#>)))
//            }
//        }
//        if interactor.words[indexPath.row].locked {
//  
//        }
    }
    
    
    
    
}
