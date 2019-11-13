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
}



class CharacterListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let configurator: CharacterListConfiguratorProtocol = CharacterListCofigurator()
    var presenter: CharacterListPresenterProtocol!
    let detailSegue = "detailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configurator.configure(with: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == detailSegue {
               guard let character = sender as? Character else { return }
               let detailVC = segue.destination as! CharacterListDetailsViewController
               let configurator: CharaterListDetailsConfiguratorProtocol = CharaterListDetailsConfigurator()
               configurator.configure(with: detailVC, and: character)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as? CharacterListTableViewCell else {return UITableViewCell()}
        guard let character = presenter.getCharacter(by: indexPath) else {return UITableViewCell()}
        cell.configure(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        presenter.showCharacterDetails(for: indexPath)
    }
    
}
