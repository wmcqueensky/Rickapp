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
    
    override func bindToViewModel() {
        viewModel.favouritesPublisher
            .sink { [weak self] characters in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavouritesUpdated), name: .favouritesUpdated, object: nil)
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
    
    @objc func handleFavouritesUpdated() {
        viewModel.reloadFavourites()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favouritesUpdated, object: nil)
    }
}

extension FavouriteListViewController: UITableViewDataSource, UITableViewDelegate, CharacterTableViewCellDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterId = viewModel.favouritesPublisher.value[indexPath.row].id ?? 0
        viewModel.getCharacterById(characterId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouritesPublisher.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self)) as? CharacterTableViewCell else { return UITableViewCell() }
        
        cell.character = viewModel.favouritesPublisher.value[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func didTapFavouriteButton(for cell: CharacterTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let character = viewModel.favouritesPublisher.value[indexPath.row]
        
        if cell.favouriteButton.isSelected {
            FavouritesManager.shared.removeFromFavourites(character.id ?? 0)
        } else {
            FavouritesManager.shared.addToFavourites(character.id ?? 0)
        }
        tableView.reloadData()
    }
}
