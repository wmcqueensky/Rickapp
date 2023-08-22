//
//  CharacterListViewController.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let baseURL = "https://rickandmortyapi.com/api/character"
    let label = UILabel()
    let tableView = UITableView()
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        fetchCharacterData()
    }
    
    func setupViews() {
        label.text = "Rickapp"
        label.textColor = .white
        label.font = .italicSystemFont(ofSize: CGFloat(30))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 500
        
        self.view.addSubview(label)
        self.view.addSubview(tableView)
    }
    
    func setUpConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func fetchCharacterData() {
        guard let url = URL(string: baseURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    self.characters = response.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CharacterTableViewCell else { return UITableViewCell() }
        
        let character = characters[indexPath.row]
        
        cell.textLabel?.removeFromSuperview()
        cell.isUserInteractionEnabled = false
        cell.backgroundColor = .backgroundGray
        cell.characterImageView.kf.setImage(with: URL(string: character.image))
        cell.nameLabel.text = character.name
        cell.statusLabel.text = character.status + " - " + character.species
        cell.actualLocationLabel.text = character.location.name
        cell.actualOriginLabel.text = character.origin.name
        
        return cell
    }
    
}
