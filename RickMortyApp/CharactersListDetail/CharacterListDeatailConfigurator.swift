//
//  CharacterListDeatailConfigurator.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharaterListDetailsConfiguratorProtocol: class {
    func configure(with view: CharacterListDetailsViewController, and character: Character)
}

class CharaterListDetailsConfigurator: CharaterListDetailsConfiguratorProtocol {
    func configure(with view: CharacterListDetailsViewController, and character: Character) {
        let presenter = CharacterListDetailsPresenter(view: view)
        let interactor = CharacterListDetailsInteractor(presentor: presenter, character: character)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
