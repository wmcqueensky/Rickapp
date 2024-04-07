//
//  CharacterCircleViewCell.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 13/09/2023.
//

import UIKit
import Kingfisher
import SnapKit

protocol CharacterCircleViewCellDelegate: AnyObject {
    func didTapCharacterImage(for cell: CharacterCircleViewCell)
}

enum Alignment {
    case left
    case centre
    case right
}

class CharacterCircleViewCell: BaseTableViewCell {
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    
    weak var delegate: CharacterCircleViewCellDelegate?
  
    var character = Character() {
        didSet {
            setupCellContent()
        }
    }
    
    var alignment: Alignment = .centre {
        didSet {
            setupConstraints()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 3
        
        characterImageView.layer.cornerRadius = 75
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.borderWidth = 0
        characterImageView.isUserInteractionEnabled = true
        characterImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView)))
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.deactivate(contentView.constraints)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom)
            make.bottom.equalTo(contentView)
            make.width.centerX.equalTo(characterImageView)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
        }
        
        switch alignment {
        case .left:
            characterImageView.snp.makeConstraints { make in
                make.centerY.leading.equalTo(contentView)
            }
        case .centre:
            characterImageView.snp.makeConstraints { make in
                make.center.equalTo(contentView)
            }
        case .right:
            characterImageView.snp.makeConstraints { make in
                make.centerY.trailing.equalTo(contentView)
            }
        }
    }
    
    private func setupCellContent() {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name ?? ""
    }
    
    @objc private func didTapImageView() {
        delegate?.didTapCharacterImage(for: self)
    }
}
