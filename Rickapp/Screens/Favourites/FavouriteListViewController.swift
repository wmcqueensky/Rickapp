//
//  FavouritesViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit
import SnapKit

class FavouriteListViewController: BaseViewController<FavouriteListViewModel> {
    private let tableView = UITableView()
    
    override func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: String(describing: CharacterTableViewCell.self))
        tableView.backgroundColor = .backgroundGray
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FavouriteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = CharacterManager.shared.favourites[indexPath.row]
        viewModel.getCharacterById(characterId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharacterManager.shared.favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self)) as? CharacterTableViewCell else { return UITableViewCell() }
        
        //        cell.character = viewModel.charactersPublisher.value[indexPath.row]
        
        return cell
    }
}
