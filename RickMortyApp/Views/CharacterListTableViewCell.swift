//
//  CharacterListTableViewCell.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import UIKit

class CharacterListTableViewCell: UITableViewCell {

    func setName(with name: String?) {
        textLabel?.text = name
    }
    
    func setImage(with data: Data?) {
        if let data = data{
            imageView?.image = UIImage(data: data)
            self.layoutSubviews()
        }
    }
    
}
