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
        
        characterStackView.backgroundColor = .cellGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.layer.cornerRadius = 10
        characterStackView.clipsToBounds = true
        characterStackView.addArrangedSubviews([characterImageView, nameLabel, statusLabel, locationLabel, actualLocationLabel, originLabel, actualOriginLabel])
        characterStackView.setCustomSpacing(7, after: characterImageView)
        
        isUserInteractionEnabled = false
        backgroundColor = .backgroundGray
        contentView.addSubview(characterStackView)
    }
    
    func setupConstraints() {
        characterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 15, left: 28, bottom: 15, right: 28))
        }
        
        characterImageView.snp.makeConstraints { make in
            make.width.equalTo(characterStackView)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(characterStackView.snp.left).offset(12)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(characterStackView.snp.left).offset(12)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.left.equalTo(characterStackView.snp.left).offset(12)
        }
        
        actualLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(characterStackView.snp.left).offset(12)
        }
        
        originLabel.snp.makeConstraints { make in
            make.left.equalTo(characterStackView.snp.left).offset(12)
        }
        
        actualOriginLabel.snp.makeConstraints { make in
            make.left.equalTo(characterStackView.snp.left).offset(12)
        }
    }
}

