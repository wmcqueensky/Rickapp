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
    private var statusView = UIView()
    private var statusWrappingView = UIView()
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
    
    var character = Character() {
        didSet {
            characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
            nameLabel.text = character.name
            statusLabel.text = (character.status ?? "") + " - " + (character.species ?? "")
            actualLocationLabel.text = character.location?.name ?? ""
            actualOriginLabel.text = character.origin?.name ?? ""
            
            switch character.status {
            case "Alive":
                statusView.backgroundColor = .green
            case "Dead":
                statusView.backgroundColor = .red
            case "unknown":
                statusView.backgroundColor = .gray
            default:
                statusView.backgroundColor = .clear
            }
            
        }
    }
    
    private func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 2
        
        statusLabel.textColor = .white
        
        statusView.layer.cornerRadius = 5
        
        statusWrappingView.addSubview(statusView)
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusWrappingView, statusLabel])
        
        locationLabel.text = "Last known location:"
        locationLabel.textColor = .gray
        
        actualLocationLabel.textColor = .white
        
        originLabel.text = "First seen in:"
        originLabel.textColor = .gray
        
        actualOriginLabel.textColor = .white
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.layer.cornerRadius = 10
        characterStackView.clipsToBounds = true
        characterStackView.addArrangedSubviews([characterImageView, nameLabel, statusStackView, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, UIView()])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacing(23, after: statusStackView)
        characterStackView.setCustomSpacing(23, after: actualLocationLabel)
        characterStackView.setCustomSpacing(16, after: actualOriginLabel)
        
        isUserInteractionEnabled = false
        backgroundColor = .backgroundGray
        addSubview(characterStackView)
    }
    
    private func setupConstraints() {
        characterStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.verticalEdges.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.width.equalTo(characterStackView)
            make.height.equalTo(310)
        }
        
        statusView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(10)
        }
        
        statusWrappingView.snp.makeConstraints { make in
            make.width.equalTo(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
        }
        
        statusStackView.snp.makeConstraints { make in
            make.leading.equalTo(characterStackView.snp.leading).offset(12)
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

