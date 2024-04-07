//
//  CharacterListViewCell.swift
//  Rickapp
//
//  Created by Goodylabs on 22/08/2023.
//

import UIKit
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    let characterStackView = UIStackView()
    let characterImageView = UIImageView()
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let locationLabel = UILabel()
    let originLabel = UILabel()
    let actualLocationLabel = UILabel()
    let actualOriginLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 30)
        
        statusLabel.textColor = .white
        
        locationLabel.text = "Last known location:"
        locationLabel.textColor = .gray
        
        actualLocationLabel.textColor = .white
        
        originLabel.text = "First seen in:"
        originLabel.textColor = .gray
        
        actualOriginLabel.textColor = .white
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 10
        characterStackView.layer.cornerRadius = 10
        characterStackView.clipsToBounds = true
        characterStackView.addArrangedSubviews([characterImageView, nameLabel, statusLabel, locationLabel, actualLocationLabel, originLabel, actualOriginLabel])
        
        self.contentView.addSubview(characterStackView)
    }
    
    func setupConstraints() {
        characterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 28, bottom: 15, right: 28))
        }
    }
}

