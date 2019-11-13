//
//  CharacterListRouter.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

protocol CharacterListRouterProtocol: class {
    func openCharacterListDetailsViewController(with character: Character)
}

class CharacterListRouter {
    
    weak var viewController: CharacterListViewController!
    
    init(viewController: CharacterListViewController) {
        self.viewController = viewController
    }
}

extension CharacterListRouter: CharacterListRouterProtocol {
    func openCharacterListDetailsViewController(with character: Character) {
        viewController.performSegue(
            withIdentifier: viewController.detailSegue,
            sender: character
        )
    }
}
