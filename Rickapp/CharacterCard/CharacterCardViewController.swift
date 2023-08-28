//
//  CharacterCardViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//


import UIKit
import Kingfisher
import SnapKit

class CharacterCardViewController: BaseViewController<CharacterCardViewModel> {
    private let navigationBar = UINavigationBar()
    private let characterStackView = UIStackView()
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private var statusView = UIView()
    private let statusStackView = UIStackView()
    private let locationLabel = UILabel()
    private let originLabel = UILabel()
    private let actualLocationLabel = UILabel()
    private let actualOriginLabel = UILabel()
    private let typeLabel = UILabel()
    private let genderLabel = UILabel()
    private let speciesLabel = UILabel()
    private let episodesLabel = UILabel()
    
    private var character = Character()
    
    init(viewModel: CharacterCardViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 2
        
        statusLabel.textColor = .white
        
        statusView.layer.cornerRadius = 5
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        
        locationLabel.text = "Last known location:"
        locationLabel.textColor = .gray
        
        actualLocationLabel.textColor = .white
        
        originLabel.text = "First seen in:"
        originLabel.textColor = .gray
        
        actualOriginLabel.textColor = .white
        
        typeLabel.textColor = .gray
        
        genderLabel.textColor = .gray
        
        speciesLabel.textColor = .gray
        
        episodesLabel.textColor = .gray
        episodesLabel.numberOfLines = 0
        
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.backgroundColor = .darkGray
        characterStackView.layer.cornerRadius = 10
        characterStackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        characterStackView.clipsToBounds = true
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, typeLabel, genderLabel, speciesLabel, episodesLabel, UIView()])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacing(23, after: statusStackView)
        characterStackView.setCustomSpacing(23, after: actualLocationLabel)
        characterStackView.setCustomSpacing(16, after: actualOriginLabel)
        characterStackView.setEdgeInsets(top: 7, left: 15, bottom: 0, right:15)
        
        view.backgroundColor = .backgroundGray
        view.addSubview(navigationBar)
        view.addSubview(characterImageView)
        view.addSubview(characterStackView)
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.fetchCharacter
            .sink { [weak self] character in
                self?.character = character
                self?.setupData()
            }
            .store(in: &viewModel.cancellables)
        
    }
    
    override func setupConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(310)
        }
        
        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        statusView.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
    }
    
    override func setupData() {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name
        statusLabel.text = (character.status ?? "") + " - " + (character.species ?? "")
        actualLocationLabel.text = character.location?.name ?? ""
        actualOriginLabel.text = character.origin?.name ?? ""
        typeLabel.text = "Type: \(character.type ?? "Unknown")"
        genderLabel.text = "Gender: \(character.gender ?? "Unknown")"
        speciesLabel.text = "Species: \(character.species ?? "Unknown Species")"
        
        let episodeNumbers = character.episode?.map { $0.components(separatedBy: "/").last ?? "" } ?? []
        let episodeText = episodeNumbers.isEmpty ? "N/A" : episodeNumbers.joined(separator: ", ")

        episodesLabel.text = "Episodes: \(episodeText)"
        
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
