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
    func getCharacter(by index: Int) -> Character?
    func getCharacterName(by index: Int) -> String
    func getCharacterImage(by character: Character) -> Data?
    func getCharacterImage(by index: Int) -> Data?
    func showCharacterDetails(for index: Int)
    var charactersCount: Int? {get}
    
}

class CharacterListPresenter: CharacterListPresenterProtocol{
    
   
    weak var view: CharacterListViewProtocol!
    var interactor: CharacterListInteractorProtocol!
    private var characters: CharactersList?
    var router: CharacterListRouterProtocol!
    var imageDict = [Int : Data]()
    
    required init(view: CharacterListViewProtocol) {
        self.view = view
    }
    
    var charactersCount: Int?{
        characters?.results.count
    }
    
    func viewDidLoad() {
        interactor.fetchCharacters()
    }
    
    func getCharacter(by index: Int) -> Character? {
        if let characters = characters?.results, characters.indices.contains(index) {
            return characters[index]
        } else {
            return nil
        }
    }
    
    func getCharacterName(by index: Int) -> String {
            characters?.results[index].name ?? ""
    }

    func getCharacterImage(by character: Character) -> Data?{
        let index = characters?.results.firstIndex{ c in
            c == character
        }
        guard let i = index else {return nil}
        return imageDict[i]
    }
    func getCharacterImage(by index: Int) -> Data?{
        if let image = imageDict[index]{
            return image
        }
        if let path = characters?.results[index].image{
            interactor.getImage(by: path, and: index)
        }
        return nil
    }
    func showCharacterDetails(for index: Int) {
        if let characters = characters?.results, characters.indices.contains(index) {
            let character = characters[index]
            router.openCharacterListDetailsViewController(with: character)
        }
    }
}

extension CharacterListPresenter: CharacterListInteractorOutputProtocol{
    func imageDidRecive(_ data: Data, for index: Int) {
        view.reloadImageInCell(by: index, with: data)
    }
    
    func charactersDidReceive(_ characters: CharactersList) {
        self.characters = characters
        view.reloadData()
    }
    
    
}
