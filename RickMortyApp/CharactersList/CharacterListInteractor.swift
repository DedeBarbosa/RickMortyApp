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
    func getImage(by url: String, and index: Int)
}

protocol CharacterListInteractorOutputProtocol: class {
    func charactersDidReceive(_ characters: CharactersList)
    func imageDidRecive(_ data: Data, for index: Int)
}

class CharacterListInteractor {
    
    weak var presenter: CharacterListInteractorOutputProtocol!
    var networkService: NetworkServiceProtocol!
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
    
    func getImage(by url: String, and index: Int) {
        NetworkService.shared.getImage(by: url){ [weak self] data in
            self?.presenter.imageDidRecive(data, for: index)
        }
    }
}
