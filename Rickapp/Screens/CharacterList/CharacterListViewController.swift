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
    
    override func setupViews() {
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
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
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
        
        cell.character = viewModel.charactersPublisher.value[indexPath.row]
        
        return cell
    }
}
