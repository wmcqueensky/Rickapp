//
//  CharacterListViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 18/08/2023.
//

import UIKit
import SnapKit

class CharacterListViewController: BaseViewController<CharacterListViewModel> {
    private let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func setupViews() {
        super.setupViews()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: String(describing: CharacterTableViewCell.self))
        tableView.backgroundColor = .backgroundGray
        tableView.showsVerticalScrollIndicator = false
    
        view.addSubview(tableView)
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
        viewModel.charactersPublisher
            .sink { [weak self] characters in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate, CharacterTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characterId = viewModel.charactersPublisher.value[indexPath.row].id else { return }
        viewModel.getCharacterById(characterId)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rowCount = viewModel.charactersPublisher.value.count
        if indexPath.row == rowCount - 3 {
            viewModel.getNextCharactersPage()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersPublisher.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self)) as? CharacterTableViewCell else { return UITableViewCell() }
        let characterId = viewModel.charactersPublisher.value[indexPath.row].id
        let isSelected = viewModel.isCharacterSelectedAsFavorite(characterId ?? 0)
        
        cell.character = viewModel.charactersPublisher.value[indexPath.row]
        cell.setFavouriteButtonSelection(isSelected)
        cell.delegate = self
        cell.animateStatusView()
        
        return cell
    }
    
    func didTapFavouriteButton(for cell: CharacterTableViewCell, isSelected: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let character = viewModel.charactersPublisher.value[indexPath.row]
        viewModel.toggleFavoriteStatus(for: character, isSelected: isSelected)
    }
}
