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
    private let statusStackView = UIStackView()
    private let episodeButtonStackView = UIStackView()
    private var locationInfoButtonStackView = UIStackView()
    private var originInfoButtonStackView = UIStackView()
    private let scrollView = UIScrollView()
    private var episodesNumbers = [String]()
    private var episodesUrls = [String]()
    
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let locationLabel = UILabel()
    private let originLabel = UILabel()
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let genderLabel = UILabel()
    private let actualGenderLabel = UILabel()
    private let speciesLabel = UILabel()
    private let actualSpeciesLabel = UILabel()
    private let episodeLabel = UILabel()
    
    private let favouriteButton = FavouriteButton()
    private var statusView = StatusView()
    private let locationInfoButton = LocationInfoButton()
    private let locationDetailsButton = LocationDetailsButton()
    private let originInfoButton = LocationInfoButton()
    private let originDetailsButton = LocationDetailsButton()
    private let locationInfoView = LocationInfoView()
    private let originInfoView = LocationInfoView()
    
    override func viewWillAppear(_ animated: Bool) {
        statusView.animate()
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.characterPublisher
            .sink { [weak self] character in
                self?.setupData(character)
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.locationPublisher
            .sink { [weak self] location in
                self?.locationInfoView.location = location
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.originPublisher
            .sink { [weak self] location in
                self?.originInfoView.location = location
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 0
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        statusLabel.textColor = .white
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        
        locationLabel.text = "Last known location:"
        originLabel.text = "First seen in:"
        typeLabel.text = "Type:"
        genderLabel.text = "Gender:"
        speciesLabel.text = "Species:"
        episodeLabel.text = "Episodes:"
                
        locationInfoButton.addTarget(self, action: #selector(locationInfoButtonTapped(_:)), for: .touchUpInside)
        locationInfoView.isHidden = true
        locationInfoView.addSubview(locationDetailsButton)
        locationDetailsButton.addTarget(self, action: #selector(locationDetailsButtonTapped(_:)), for: .touchUpInside)
        locationInfoButtonStackView.addArrangedSubviews([locationInfoButton, UIView()])
        
        originInfoButton.addTarget(self, action: #selector(originInfoButtonTapped(_:)), for: .touchUpInside)
        originInfoView.isHidden = true
        originInfoView.addSubview(originDetailsButton)
        originDetailsButton.addTarget(self, action: #selector(originDetailsButtonTapped(_:)), for: .touchUpInside)
        originInfoButtonStackView.addArrangedSubviews([originInfoButton, UIView()])
        
        view.setFontForLabels([statusLabel, locationLabel, originLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodeLabel], font: .systemFont(ofSize: 20))
        view.setTextColorForLabels([statusLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel], color: .white)
        view.setTextColorForLabels([locationLabel, originLabel, typeLabel, genderLabel, speciesLabel, episodeLabel], color: .gray)
        
        characterImageView.contentMode = .scaleAspectFill
        
        episodeButtonStackView.axis = .vertical
        episodeButtonStackView.spacing = 12
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, locationInfoButtonStackView, locationInfoView, originLabel, originInfoButtonStackView, originInfoView,typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodeLabel, episodeButtonStackView])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacing(12, after: episodeLabel)
        characterStackView.setCustomSpacings(20, [statusStackView, locationInfoButtonStackView, originInfoButtonStackView, actualTypeLabel, actualGenderLabel, actualSpeciesLabel])
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
        
        favouriteButton.snp.makeConstraints { make in
            make.top.equalTo(characterImageView).offset(10)
            make.trailing.equalTo(characterImageView).offset(-10)
        }
        
        locationDetailsButton.snp.makeConstraints { make in
            make.bottom.equalTo(locationInfoView).offset(-20)
            make.trailing.equalTo(locationInfoView)
        }
        
        originDetailsButton.snp.makeConstraints { make in
            make.bottom.equalTo(originInfoView).offset(-20)
            make.trailing.equalTo(originInfoView)
        }
    }
    
    private func setupData(_ character: Character) {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        nameLabel.text = character.name
        statusLabel.text = (character.status ?? "") + " - " + (character.species ?? "")
        locationInfoButton.setTitle(character.location?.name ?? "", for: .normal)
        originInfoButton.setTitle(character.origin?.name ?? "", for: .normal)
        actualTypeLabel.text = character.type ?? ""
        actualGenderLabel.text = character.gender ?? ""
        actualSpeciesLabel.text = character.species ?? ""
        
        if let episodes = character.episode {
            for episodeURL in episodes {
                if let episodeNumber = episodeURL.split(separator: "/").last {
                    episodesNumbers.append(String(episodeNumber))
                    episodesUrls.append(episodeURL)
                }
            }
            
            for episode in episodesNumbers {
                let episodeButton = EpisodeButton()
                episodeButton.setTitle("Episode: \(episode)", for: .normal)
                episodeButton.addTarget(self, action: #selector(episodeButtonTapped(_:)), for: .touchUpInside)
                
                episodeButtonStackView.addArrangedSubviews([episodeButton])
            }
        }
        
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
        statusView.animate()
        favouriteButton.isSelected = viewModel.isCharacterSelectedAsFavorite(character.id ?? 0)
    }
    
    @objc private func locationInfoButtonTapped(_ sender: LocationInfoButton) {
        sender.isSelected.toggle()
        locationInfoView.toggle()
    }
    
    @objc private func originInfoButtonTapped(_ sender: LocationInfoButton) {
        sender.isSelected.toggle()
        originInfoView.toggle()
    }
    
    @objc private func favouriteButtonTapped() {
        let characterId = viewModel.characterPublisher.value.id ?? 0
        
        favouriteButton.isSelected.toggle()
        viewModel.manageFavourites(isSelected: favouriteButton.isSelected, characterId: characterId)
        favouriteButton.animateHeartImage()
    }
    
    @objc private func locationDetailsButtonTapped(_ sender: LocationInfoButton) {
        let locationUrl = viewModel.characterPublisher.value.location?.url ?? ""
        if locationUrl == "" { return }
        
        viewModel.locationDetailsButtonTapped(locationUrl)
    }
    
    @objc private func originDetailsButtonTapped(_ sender: LocationInfoButton) {
        let originUrl = viewModel.characterPublisher.value.origin?.url ?? ""
        if originUrl == "" { return }
        
        viewModel.locationDetailsButtonTapped(originUrl)
    }
    
    @objc private func episodeButtonTapped(_ sender: EpisodeButton) {
        guard let buttonIndex = episodeButtonStackView.arrangedSubviews.firstIndex(of: sender) else { return }
        
        sender.animateTap()
        if buttonIndex < episodesUrls.count {
            let episodeUrl = episodesUrls[buttonIndex]
            viewModel.episodeButtonTapped(episodeUrl)
        }
    }
}
