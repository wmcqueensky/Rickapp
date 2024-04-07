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
    private var statusView = UIView()
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
        
        statusView.layer.cornerRadius = 6
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 12
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        statusStackView.setEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)

        speciesImageView.image = UIImage.getImage(.atomIcon)
        
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
        statusView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
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
            statusView.backgroundColor = .green
        case "Dead":
            statusView.backgroundColor = .red
        case "unknown":
            statusView.backgroundColor = .gray
        default:
            statusView.backgroundColor = .clear
        }
        animateStatusView()
    }
    
    func animateStatusView() {
        self.statusView.transform = .identity
        self.statusView.alpha = 1
        
        if let backgroundColor = statusView.backgroundColor {
            switch backgroundColor {
            case .green:
                UIView.animate(withDuration: 0.5, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                    self.statusView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    self.statusView.alpha = 0.8
                })
            case .red:
                UIView.animate(withDuration: 0.9, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                    self.statusView.transform = CGAffineTransform(scaleX: 1.0, y: 0.3)
                    self.statusView.alpha = 0.8
                })
            default:
                UIView.animate(withDuration: 0.9, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                    self.statusView.alpha = 0.1
                })
            }
        }
    }
}

