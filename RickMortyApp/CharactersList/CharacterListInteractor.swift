//
//  CharacterListInteractor.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharacterListInteractorProtocol: class {
    func fetchCharacters()
}

protocol CharacterListInteractorOutputProtocol: class {
    func charactersDidReceive(_ characters: CharactersList)
}

class CharacterListInteractor {
    
    weak var presenter: CharacterListInteractorOutputProtocol!
    
    required init(presenter: CharacterListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension CharacterListInteractor: CharacterListInteractorProtocol {
    func fetchCharacters() {
        NetworkService.shared.fetchMovieList{ [weak self] characters in
            self?.presenter.charactersDidReceive(characters)
        }
    }
}
