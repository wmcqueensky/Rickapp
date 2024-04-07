//
//  BaseViewController.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import UIKit
import SnapKit
import Kingfisher

class BaseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        label.text = "This is Rickapp"
        label.textColor = .white
        label.font = .italicSystemFont(ofSize: CGFloat(30))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 200
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = characters[indexPath.row]
        
        cell.textLabel?.text = character.name + "\n\(character.status) - \(character.species) \nLast known location:\n\(character.location.name) \nFirst seen in:\n\(character.origin.name)"
        
        if let imageURL = URL(string: character.image) {
            cell.imageView?.kf.setImage(with: imageURL)
        }
        
        return cell
    }
}
