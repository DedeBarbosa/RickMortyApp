//
//  Model.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import Foundation

struct CharactersList: Decodable{
    var results: [Character]
}

struct Character: Decodable{
    let id: Int
    let name: String
    let image: String
    let status: String
    let species: String
    let gender: String
}
