//
//  GamePresenter.swift
//  Anagrams
//
//  Created by Anastasia Koldunova on 24.09.2024.
//

import UIKit


protocol GameView: AnyObject {
    func reload()
}


protocol GamePresenterProtocol: UICollectionViewDelegate, UICollectionViewDataSource {
    init(view: GameView, router: GameRouterProtocol, interactor: GameInteractorProtocol)
    
    func getWold() -> String
    func checkIfWorldIsCorrect(word: String) -> Bool
}


class GamePresenter: NSObject, GamePresenterProtocol {
    weak var view: GameView?
    private var router: GameRouterProtocol
    private var interactor: GameInteractorProtocol
    
    
    
    required init(view: GameView, router: GameRouterProtocol, interactor: GameInteractorProtocol) {
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

extension GamePresenter: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.words?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "anagrams_cell", for: indexPath) as! AnagramsCollectionViewCell
        if let data =  interactor.words?[indexPath.row] {
            cell.configure(data.title, isAvailable: !data.locked)
        }
        return cell
    }
    
    
}
