//
//  CharacterListModel.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharacterListConfiguratorProtocol: class {
    func configure(with viewController: CharacterListViewController)
}

class CharacterListCofigurator: CharacterListConfiguratorProtocol {
    func configure(with viewController: CharacterListViewController) {
        let presenter = CharacterListPresenter(view: viewController)
        let interactor = CharacterListInteractor(presenter: presenter)
        let router = CharacterListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
