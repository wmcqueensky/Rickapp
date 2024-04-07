//
//  CharacterTileTableViewCell.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 11/09/2023.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterTileTableViewCell: BaseTableViewCell {
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let speciesLabel = UILabel()
    private let speciesImageView = UIImageView()
    private let speciesStackView = UIStackView()
    private var statusView = StatusView()
    private let statusStackView = UIStackView()
    private let informationStackView = UIStackView()
    
    var character = Character() {
        didSet {
            setupCellContent()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        nameLabel.font = .boldSystemFont(ofSize: 28)
        nameLabel.numberOfLines = 2
        
        statusLabel.font = .systemFont(ofSize: 18)
        statusLabel.numberOfLines = 2
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 12
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        statusStackView.setEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        
        speciesImageView.image = UIImage.getImage(.atomIcon)
        animateSpeciesImageView()
        
        speciesLabel.font = .systemFont(ofSize: 20)
        speciesLabel.numberOfLines = 2
        
        speciesStackView.axis = .horizontal
        speciesStackView.spacing = 6
        speciesStackView.addArrangedSubviews([speciesImageView, speciesLabel])
        speciesStackView.alignment = .center
        
        setTextColorForLabels([nameLabel, statusLabel, speciesLabel], color: .white)
        
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        
        informationStackView.backgroundColor = .darkGray
        informationStackView.axis = .vertical
        informationStackView.spacing = 5
        informationStackView.layer.cornerRadius = 10
        informationStackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        informationStackView.clipsToBounds = true
        informationStackView.addArrangedSubviews([nameLabel, statusStackView, speciesStackView])
        informationStackView.setEdgeInsets(top: 4, left: 16, bottom: 8, right: 0)
        
        selectionStyle = .none
        backgroundColor = .backgroundGray
        contentView.addSubview(informationStackView)
        contentView.addSubview(characterImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        speciesImageView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(10)
            make.trailing.equalTo(contentView).inset(18)
            make.leading.equalTo(characterImageView.snp.trailing)
            make.height.equalTo(characterImageView)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).inset(18)
            make.width.height.equalTo(130)
        }
    }
    
    private func setupCellContent() {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name ?? ""
        statusLabel.text = character.status ?? ""
        speciesLabel.text = character.species ?? ""
        
        switch character.status {
        case "Alive":
            statusView.style = .alive
        case "Dead":
            statusView.style = .dead
        case "unknown":
            statusView.style = .unknown
        default:
            statusView.backgroundColor = .clear
        }
    }
    
    func animateStatusView() {
        statusView.animate()
    }
    
    func animateSpeciesImageView() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi * 2.0 * 2.5
        rotationAnimation.duration = 10.0
        rotationAnimation.repeatCount = .infinity
        
        speciesImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}

