//
//  CharacterListViewCell.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 22/08/2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol CharacterTableViewCellDelegate: AnyObject {
    func didTapFavouriteButton(for cell: CharacterTableViewCell, isSelected: Bool)
}

class CharacterTableViewCell: BaseTableViewCell {
    weak var delegate: CharacterTableViewCellDelegate?
    private let characterStackView = UIStackView()
    private let characterImageView = UIImageView()
    private let favouriteButton = FavouriteButton()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private var statusView = StatusView()
    private let statusStackView = UIStackView()
    private let locationLabel = UILabel()
    private let originLabel = UILabel()
    private let actualLocationLabel = UILabel()
    private let actualOriginLabel = UILabel()
    
    var character = Character() {
        didSet {
            setupCellContent()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 0
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        statusView.style = .small
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        
        statusView.animate()
        
        locationLabel.text = "Last known location:"
        
        originLabel.text = "First seen in:"
        
        setTextColorForLabels([locationLabel, originLabel], color: .gray)
        setTextColorForLabels([nameLabel, statusLabel, actualLocationLabel, actualOriginLabel], color: .white)
        
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.layer.cornerRadius = 10
        characterStackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        characterStackView.clipsToBounds = true
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, UIView()])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacing(16, after: actualOriginLabel)
        characterStackView.setCustomSpacings(23, [statusStackView, actualLocationLabel])
        characterStackView.setEdgeInsets(top: 7, left: 15, bottom: 0, right:15)
        
        selectionStyle = .none
        backgroundColor = .backgroundGray
        contentView.addSubview(characterImageView)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(characterStackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        characterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.top.equalTo(contentView).inset(18)
            make.height.equalTo(characterImageView.snp.width)
        }
        
        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom)
            make.horizontalEdges.equalTo(contentView).inset(15)
            make.bottom.equalTo(contentView).inset(18)
        }
        
        favouriteButton.snp.makeConstraints { make in
            make.top.equalTo(characterImageView).offset(10)
            make.trailing.equalTo(characterImageView).offset(-10)
        }
    }
    
    private func setupCellContent() {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name ?? ""
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
    
    func animateStatusView() {
        statusView.animate()
    }
    
    func setFavouriteButtonSelection(_ isSelected: Bool) {
        favouriteButton.isSelected = isSelected
    }
    
    @objc private func favouriteButtonTapped() {
        favouriteButton.isSelected.toggle()
        delegate?.didTapFavouriteButton(for: self, isSelected: favouriteButton.isSelected)
        favouriteButton.animateHeartImage()
    }
}

