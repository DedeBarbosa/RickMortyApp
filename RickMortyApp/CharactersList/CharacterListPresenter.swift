//
//  CharacterListPresenter.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharacterListPresenterProtocol: class{
    
    func viewDidLoad()
    func getCharacter(by indexPath:IndexPath) -> Character?
    func showCharacterDetails(for indexPath: IndexPath)
    
    var charactersCount: Int? {get}
    
}

class CharacterListPresenter: CharacterListPresenterProtocol{
    
    weak var view: CharacterListViewProtocol!
    var interactor: CharacterListInteractorProtocol!
    private var characters: CharactersList?
    var router: CharacterListRouterProtocol!
    
    required init(view: CharacterListViewProtocol) {
        self.view = view
    }
    
    var charactersCount: Int?{
        characters?.results.count
    }
    
    func viewDidLoad() {
        interactor.fetchCharacters()
    }
    
    func getCharacter(by indexPath:IndexPath) -> Character? {
        if let characters = characters?.results, characters.indices.contains(indexPath.row) {
            return characters[indexPath.row]
        } else {
            return nil
        }
    }
    func showCharacterDetails(for indexPath: IndexPath) {
        if let characters = characters?.results, characters.indices.contains(indexPath.row) {
            let character = characters[indexPath.row]
            router.openCharacterListDetailsViewController(with: character)
        }
    }
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol{
    func charactersDidReceive(_ characters: CharactersList) {
        self.characters = characters
        view.reloadData()
    }
    
    
}
