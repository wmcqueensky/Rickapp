//
//  CharacterDetailsViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//

import UIKit
import Combine
import SnapKit

class CharacterDetailsViewController: BaseViewController<CharacterDetailsViewModel> {
    private let characterStackView = UIStackView()
    private let characterImageView = UIImageView()
    private let favouriteButton = FavouriteButton()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private var statusView = UIView()
    private let statusStackView = UIStackView()
    private let locationLabel = UILabel()
    private let locationButton = UIButton()
    private let originLabel = UILabel()
    private let originButton = UIButton()
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let genderLabel = UILabel()
    private let actualGenderLabel = UILabel()
    private let speciesLabel = UILabel()
    private let actualSpeciesLabel = UILabel()
    private let episodesLabel = UILabel()
    private let episodeButtonStackView = UIStackView()
    private var episodeButtons: [UIButton] = []
    private let scrollView = UIScrollView()
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.characterPublisher
            .sink { [weak self] character in
                self?.setupData(character)
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 0
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        statusLabel.textColor = .white
        
        statusView.layer.cornerRadius = 6
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        
        locationLabel.text = "Last known location:"
        
        originLabel.text = "First seen in:"
        
        typeLabel.text = "Type:"
        
        genderLabel.text = "Gender:"
        
        speciesLabel.text = "Species:"
        
        episodesLabel.text = "Episodes:"
        
        locationButton.contentHorizontalAlignment = .left
        locationButton.titleLabel?.font = .systemFont(ofSize: 20)
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        originButton.contentHorizontalAlignment = .left
        originButton.titleLabel?.font = .systemFont(ofSize: 20)
        originButton.addTarget(self, action: #selector(originButtonTapped), for: .touchUpInside)
        
        view.setFontForLabels([statusLabel, locationLabel, originLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel], font: .systemFont(ofSize: 20))
        view.setTextColorForLabels([statusLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel], color: .white)
        view.setTextColorForLabels([locationLabel, originLabel, typeLabel, genderLabel, speciesLabel, episodesLabel], color: .gray)
        
        characterImageView.contentMode = .scaleAspectFill
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, locationButton, originLabel, originButton, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel, episodeButtonStackView])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacings(20, [statusStackView, locationButton, originButton, actualTypeLabel, actualGenderLabel, actualSpeciesLabel])
        characterStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        
        view.backgroundColor = .darkGray
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(characterImageView)
        scrollView.addSubview(favouriteButton)
        scrollView.addSubview(characterStackView)
        view.addSubview(scrollView)
    }
    
    override func setupConstraints() {
        characterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.top.equalTo(scrollView)
            make.height.equalTo(characterImageView.snp.width)
        }
        
        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom)
            make.horizontalEdges.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        statusView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        favouriteButton.snp.makeConstraints { make in
            make.top.equalTo(characterImageView).offset(10)
            make.trailing.equalTo(characterImageView).offset(-10)
        }
    }
    
    private func setupData(_ character: Character) {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name
        statusLabel.text = (character.status ?? "") + " - " + (character.species ?? "")
        locationButton.setTitle(character.location?.name ?? "", for: .normal)
        originButton.setTitle(character.origin?.name ?? "", for: .normal)
        actualTypeLabel.text = character.type ?? ""
        actualGenderLabel.text = character.gender ?? ""
        actualSpeciesLabel.text = character.species ?? ""
        
        if let episodes = character.episode {
            for episode in episodes {
                let episodeButton = UIButton()
                episodeButton.setTitle("Episode: \(episode)", for: .normal)
                episodeButton.titleLabel?.font = .systemFont(ofSize: 20)
                episodeButton.setTitleColor(.white, for: .normal)
                episodeButton.contentHorizontalAlignment = .left
                episodeButton.addTarget(self, action: #selector(episodeButtonTapped), for: .touchUpInside)
                
                episodeButtonStackView.addArrangedSubview(episodeButton)
            }
        }
        
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
        
        favouriteButton.isSelected = FavouritesManager.shared.favourites.contains(character.id ?? 0)
    }
    
    @objc private func favouriteButtonTapped() {
        let characterId = viewModel.characterPublisher.value.id ?? 0
        
        favouriteButton.isSelected.toggle()
        favouriteButton.isSelected ?
        FavouritesManager.shared.addToFavourites(characterId) :
        FavouritesManager.shared.removeFromFavourites(characterId)
    }
    
    @objc private func locationButtonTapped() {
        let locationUrl = viewModel.characterPublisher.value.location?.url ?? ""
        if locationUrl == "" { return }
        
        viewModel.locationButtonsTapped(locationUrl)
        
        UIView.animate(withDuration: 0.2) {
            self.locationButton.setTitleColor(.gray, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 2.0) {
                self.locationButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc private func originButtonTapped() {
        let originUrl = viewModel.characterPublisher.value.origin?.url ?? ""
        if originUrl == "" { return }
        
        viewModel.locationButtonsTapped(originUrl)
        
        UIView.animate(withDuration: 0.2) {
            self.originButton.setTitleColor(.gray, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 2.0) {
                self.originButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc private func episodeButtonTapped() {
        
    }
}
