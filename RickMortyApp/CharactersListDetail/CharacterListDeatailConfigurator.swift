//
//  CharacterListDeatailConfigurator.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharacterListDetailsConfiguratorProtocol: class {
    func configure(view: CharacterListDetailsViewController, with character: Character, and image: Data?)
}

class CharacterListDetailsConfigurator: CharacterListDetailsConfiguratorProtocol {
    func configure(view: CharacterListDetailsViewController, with character: Character, and image: Data?) {
        let presenter = CharacterListDetailsPresenter(view: view)
        let interactor = CharacterListDetailsInteractor(presenter: presenter, character: character, image: image)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
