//
//  CharacterListViewController.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import UIKit
import SnapKit

class CharacterListViewController: BaseViewController<CharacterListViewModel> {
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    
    init(viewModel: CharacterListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        titleLabel.text = "Rickapp"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .italicSystemFont(ofSize: CGFloat(30))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: String(describing: CharacterTableViewCell.self))
        tableView.backgroundColor = .backgroundGray
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] characters in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self)) as? CharacterTableViewCell else { return UITableViewCell() }
        
        cell.character = viewModel.characters[indexPath.row]
        
        return cell
    }
}
