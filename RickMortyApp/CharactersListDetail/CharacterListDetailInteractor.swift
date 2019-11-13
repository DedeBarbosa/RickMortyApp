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
    
    weak var presentor: CharacterListDetailsIneractorOutputProtocol!
    private var character: Character
    
    
    init(presentor: CharacterListDetailsIneractorOutputProtocol, character: Character) {
        self.presentor = presentor
        self.character = character
    }
}

extension CharacterListDetailsInteractor: CharacterListDetailsInteractorProtocol {
    func provideCharacterListDetails() {
        presentor.receiveCharacter(character: character)
        if let data = NetworkService.shared.getImage(by: character.image){
            presentor.recieveImage(data: data)
        }
    }
    
}
