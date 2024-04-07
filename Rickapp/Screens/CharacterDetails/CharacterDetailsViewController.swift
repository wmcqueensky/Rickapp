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
    private let actualOriginLabel = UILabel()
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let genderLabel = UILabel()
    private let actualGenderLabel = UILabel()
    private let speciesLabel = UILabel()
    private let actualSpeciesLabel = UILabel()
    private let episodesLabel = UILabel()
    private let actualEpisodesLabel = UILabel()
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
        
        view.setFontForLabels([statusLabel, locationLabel, originLabel, actualOriginLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel], font: .systemFont(ofSize: 20))
        view.setTextColorForLabels([statusLabel, actualOriginLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel, actualEpisodesLabel], color: .white)
        view.setTextColorForLabels([locationLabel, originLabel, typeLabel, genderLabel, speciesLabel, episodesLabel], color: .gray)
        
        actualEpisodesLabel.font = .systemFont(ofSize: 25)
        actualEpisodesLabel.numberOfLines = 0
        
        characterImageView.contentMode = .scaleAspectFill
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, locationButton, originLabel, actualOriginLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel, actualEpisodesLabel])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacings(20, [statusStackView, locationButton, actualOriginLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel])
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
        actualOriginLabel.text = character.origin?.name ?? ""
        actualTypeLabel.text = character.type ?? ""
        actualGenderLabel.text = character.gender ?? ""
        actualSpeciesLabel.text = character.species ?? ""
        
        let episodeNumbers = character.episode?.map { $0.components(separatedBy: "/").last ?? "" } ?? []
        let episodeText = episodeNumbers.isEmpty ? "N/A" : episodeNumbers.joined(separator: ", ")
        
        let formattedEpisodes = episodeNumbers.map { "Episode: \($0)" }
        let formattedEpisodeText = formattedEpisodes.joined(separator: "\n")
        
        actualEpisodesLabel.text = formattedEpisodeText
        
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
        
        UIView.animate(withDuration: 0.2) {
            self.locationButton.setTitleColor(.gray, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 2.0) {
                self.locationButton.setTitleColor(.white, for: .normal)
                
            }
        }
        viewModel.locationButtonTapped(locationUrl)
    }
}
