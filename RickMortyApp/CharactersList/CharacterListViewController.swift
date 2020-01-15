//
//  CharacterListViewController.swift
//  RickMortyApp
//
//  Created by Dmitry Pavlov on 13.11.2019.
//  Copyright © 2019 Dmitry Pavlov. All rights reserved.
//

import UIKit

protocol CharacterListViewProtocol: class{
    func reloadData()
    func reloadImageInCell(by index: Int, with data: Data)
}



class CharacterListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let configurator: CharacterListConfiguratorProtocol = CharacterListConfigurator()
    var presenter: CharacterListPresenterProtocol!
    let detailSegue = "detailSegue"
    let cellReuseId = "characterListCell"
    let cellClass = CharacterListTableViewCell.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellClass, forCellReuseIdentifier: cellReuseId)
        configurator.configure(with: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == detailSegue {
               guard let character = sender as? Character else { return }
               let detailVC = segue.destination as! CharacterListDetailsViewController
               let configurator: CharacterListDetailsConfiguratorProtocol = CharacterListDetailsConfigurator()
            configurator.configure(view: detailVC, with: character, and: presenter.getCharacterImage(by: character))
       }
    }
       
}

extension CharacterListViewController: CharacterListViewProtocol{
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.charactersCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId) as? CharacterListTableViewCell else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.setName(with: self.presenter.getCharacterName(by: indexPath.row))
        }
        DispatchQueue.main.async {
            cell.setImage(with: self.presenter.getCharacterImage(by: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        presenter.showCharacterDetails(for: indexPath.row)
    }
    
    func reloadImageInCell(by index: Int, with data: Data) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CharacterListTableViewCell else {return}
        cell.setImage(with: data)
    }
    
}
