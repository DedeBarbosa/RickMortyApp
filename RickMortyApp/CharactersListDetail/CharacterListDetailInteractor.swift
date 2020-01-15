//
//  CharacterListDetailInteractor.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharacterListDetailsInteractorProtocol: class {
    func provideCharacterListDetails()
}

protocol CharacterListDetailsIneractorOutputProtocol: class {
    func receiveCharacter(character: Character)
    func recieveImage(data: Data?)
}

class CharacterListDetailsInteractor {
    
    weak var presenter: CharacterListDetailsIneractorOutputProtocol!
    private var character: Character
    private var imageData: Data?
    
    
    init(presenter: CharacterListDetailsIneractorOutputProtocol, character: Character, image: Data?) {
        self.presenter = presenter
        self.character = character
        self.imageData = image
    }
}

extension CharacterListDetailsInteractor: CharacterListDetailsInteractorProtocol {
    func provideCharacterListDetails() {
        presenter.receiveCharacter(character: character)
        if let image = imageData{
            presenter.recieveImage(data: image)
        } else{
            NetworkService.shared.getImage(by: character.image){ [weak self] data in
                self?.presenter.recieveImage(data: data)
            }
        }
    }
    
}
