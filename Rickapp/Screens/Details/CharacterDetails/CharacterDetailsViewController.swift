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
    private let locationButton = LocationButton()
    private let originLabel = UILabel()
    private let originButton = LocationButton()
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let genderLabel = UILabel()
    private let actualGenderLabel = UILabel()
    private let speciesLabel = UILabel()
    private let actualSpeciesLabel = UILabel()
    private let episodeLabel = UILabel()
    private let episodeButtonStackView = UIStackView()
    private let scrollView = UIScrollView()
    private var episodesNumbers = [String]()
    private var episodesUrls = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        animateStatusView()
    }
    
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
        
        episodeLabel.text = "Episodes:"
        
        locationButton.addTarget(self, action: #selector(locationButtonTapped(_:)), for: .touchUpInside)
        
        originButton.addTarget(self, action: #selector(originButtonTapped(_:)), for: .touchUpInside)
        
        view.setFontForLabels([statusLabel, locationLabel, originLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodeLabel], font: .systemFont(ofSize: 20))
        view.setTextColorForLabels([statusLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel], color: .white)
        view.setTextColorForLabels([locationLabel, originLabel, typeLabel, genderLabel, speciesLabel, episodeLabel], color: .gray)
        
        characterImageView.contentMode = .scaleAspectFill
        
        episodeButtonStackView.axis = .vertical
        episodeButtonStackView.spacing = 12
        
        characterStackView.backgroundColor = .darkGray
        characterStackView.axis = .vertical
        characterStackView.spacing = 3
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, locationButton, originLabel, originButton, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodeLabel, episodeButtonStackView])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacing(12, after: episodeLabel)
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
            statusView.backgroundColor = .green
        case "Dead":
            statusView.backgroundColor = .red
        case "unknown":
            statusView.backgroundColor = .gray
        default:
            statusView.backgroundColor = .clear
        }
        animateStatusView()
        favouriteButton.isSelected = viewModel.isCharacterSelectedAsFavorite(character.id ?? 0)
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
    
    @objc private func favouriteButtonTapped() {
        let characterId = viewModel.characterPublisher.value.id ?? 0
        
        favouriteButton.isSelected.toggle()
        viewModel.manageFavourites(isSelected: favouriteButton.isSelected, characterId: characterId)
        
        favouriteButton.animateHeartImage()
    }
    
    @objc private func locationButtonTapped(_ sender: LocationButton) {
        let locationUrl = viewModel.characterPublisher.value.location?.url ?? ""
        if locationUrl == "" { return }
        sender.animateTap()
        
        viewModel.locationButtonTapped(locationUrl)
    }
    
    @objc private func originButtonTapped(_ sender: LocationButton) {
        let originUrl = viewModel.characterPublisher.value.origin?.url ?? ""
        if originUrl == "" { return }
        sender.animateTap()
        
        viewModel.locationButtonTapped(originUrl)
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
