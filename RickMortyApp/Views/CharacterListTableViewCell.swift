//
//  CharacterListTableViewCell.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import UIKit

class CharacterListTableViewCell: UITableViewCell {

    func configure(with character: Character) {
        textLabel?.text = character.name
        if let data = NetworkService.shared.getImage(by: character.image){
            imageView?.image = UIImage(data: data)
        }
    }
}
