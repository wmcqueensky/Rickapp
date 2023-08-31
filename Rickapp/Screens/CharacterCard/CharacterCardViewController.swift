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
    private let characterStackView = UIStackView()
    private let characterImageView = UIImageView()
    private let favouriteButton = FavouriteButton()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private var statusView = UIView()
    private let statusStackView = UIStackView()
    private let locationLabel = UILabel()
    private let actualLocationLabel = UILabel()
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
                self?.favouriteButton.isSelected = self?.viewModel.favourites.contains(character) ?? false
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.favourites
            .sink { [weak self] _ in
                if let character = self?.viewModel.characterPublisher.value {
                    self?.favouriteButton.isSelected = self?.viewModel.favourites.contains(character) ?? false
                }
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 0
        
        favouriteButton.addTarget(self, action: #selector(FavouriteButtonTapped), for: .touchUpInside)
        
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
        
        view.setFontForLabels([statusLabel, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel], font: .systemFont(ofSize: 20))
        view.setTextColorForLabels([statusLabel, actualLocationLabel, actualOriginLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel, actualEpisodesLabel], color: .white)
        view.setTextColorForLabels([locationLabel, originLabel, typeLabel, genderLabel, speciesLabel, episodesLabel], color: .gray)
        
        actualEpisodesLabel.font = .systemFont(ofSize: 25)
        actualEpisodesLabel.numberOfLines = 0
        
        characterImageView.contentMode = .scaleAspectFill
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel, actualEpisodesLabel])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacings(20, [statusStackView, actualLocationLabel, actualOriginLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel])
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
        actualLocationLabel.text = character.location?.name ?? ""
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
    }
    
    @objc func FavouriteButtonTapped() {
        favouriteButton.isSelected.toggle()
        if let character = viewModel.characterPublisher.value {
            if favouriteButton.isSelected {
                viewModel.addToFavourites(character)
            } else {
                viewModel.removeFromFavourites(character)
            }
        }
    }
}
