//
//  CharacterListViewCell.swift
//  Rickapp
//
//  Created by Goodylabs on 22/08/2023.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    private let characterStackView = UIStackView()
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private var statusImage = UIImageView()
    private let statusStackView = UIStackView()
    private let locationLabel = UILabel()
    private let originLabel = UILabel()
    private let actualLocationLabel = UILabel()
    private let actualOriginLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with character: Character) {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name
        statusLabel.text = (character.status ?? "") + " - " + (character.species ?? "")
        actualLocationLabel.text = character.location?.name ?? ""
        actualOriginLabel.text = character.origin?.name ?? ""
        
        if character.status == "Alive" {
            statusImage.image = .getImage(.greenStatus)
        }
        
        if character.status == "Dead" {
            statusImage.image = .getImage(.redStatus)
            
        }
        
        if character.status == "unknown" {
            statusImage.image = .getImage(.grayStatus)
        }
    }
    
    func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 2
        
        statusLabel.textColor = .white
        
        statusImage.contentMode = .scaleAspectFit
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusImage, statusLabel])
        
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
        characterStackView.addArrangedSubviews([characterImageView, nameLabel, statusStackView, locationLabel, actualLocationLabel, originLabel, actualOriginLabel])
        
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
            make.height.equalTo(310)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
        }
        
        statusStackView.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
            make.height.equalTo(13)
        }
        
        statusImage.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
        }
        
        actualLocationLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
        }
        
        originLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
        }
        
        actualOriginLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
        }
    }
}

