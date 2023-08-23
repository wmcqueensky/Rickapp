//
//  CharacterListViewController.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import UIKit
import SnapKit

class CharacterListViewController: CharacterListViewModel {
    private let titleLabel = UILabel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
        setUpConstraints()
    }
    
    func setupViews() {
        titleLabel.text = "Rickapp"
        titleLabel.textColor = .white
        titleLabel.font = .italicSystemFont(ofSize: CGFloat(30))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .backgroundGray
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CharacterTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
}
