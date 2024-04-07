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
    
    var characters: [Character] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var networkProvider: Networkable!
    
    init(networkProvider: Networkable) {
        super.init(nibName: nil, bundle: nil)
        self.networkProvider = networkProvider
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
        networkProvider.getNewCharacters(page: 5) { [weak self] characters in
            self?.characters = characters
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let character = characters[indexPath.row]
        
        cell.textLabel?.text = character.name
        
        var detailText = "\(character.status) - \(character.species)"
        
        detailText += "\nLast known location:\n\(character.location.name)"
        detailText += "\nFirst seen in:\n\(character.origin.name)"
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = detailText
        
        if let imageURL = URL(string: character.image) {
            cell.imageView?.kf.setImage(with: imageURL)
        }
        
        return cell
    }
}
