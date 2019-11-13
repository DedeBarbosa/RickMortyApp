//
//  CharacterListDetailsViewController.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import UIKit

protocol CharacterListDetailsViewProtocol: class {
    func seteName(with title: String?)
    func setStatus(with title: String?)
    func setSpecies(with title: String?)
    func setGender(with title: String?)
    func setImage(with imageData: Data?)
    
}

class CharacterListDetailsViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var presenter: CharacterListDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetail()
    }
    
}

extension CharacterListDetailsViewController: CharacterListDetailsViewProtocol{
    func setImage(with imageData: Data?) {
        if let data = imageData{
            image.image = UIImage(data: data)
        }
    }
    
    func seteName(with title: String?) {
        name.text = title
    }
    
    func setStatus(with title: String?) {
        status.text = title
    }
    
    func setSpecies(with title: String?) {
        species.text = title
    }
    
    func setGender(with title: String?) {
        gender.text = title
    }
    
}
