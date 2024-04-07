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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePushNavigationBar()
        navigationController?.setNavigationBarHidden(scrollView.contentOffset.y > 0, animated: false)
    }
    
    override func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 50)
        
        statusLabel.textColor = .white
        statusLabel.setFontForLabels([statusLabel, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel], font: .systemFont(ofSize: 20))
        statusLabel.setTextColorForLabels([statusLabel, actualLocationLabel, actualOriginLabel, actualTypeLabel, actualGenderLabel, actualSpeciesLabel, actualEpisodesLabel], color: .white)
        
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
        episodesLabel.setTextColorForLabels([locationLabel, originLabel, typeLabel, genderLabel, speciesLabel, episodesLabel], color: .gray)
        
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
        scrollView.addSubview(characterStackView)
        view.addSubview(scrollView)
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.characterPublisher
            .sink { [weak self] character in
                self?.setupData()
            }
            .store(in: &viewModel.cancellables)
        
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
    }
    
    override func setupData() {
        characterImageView.kf.setImage(with: URL(string: viewModel.character.image ?? ""))
        nameLabel.text = viewModel.character.name
        statusLabel.text = (viewModel.character.status ?? "") + " - " + (viewModel.character.species ?? "")
        actualLocationLabel.text = viewModel.character.location?.name ?? ""
        actualOriginLabel.text = viewModel.character.origin?.name ?? ""
        actualTypeLabel.text = viewModel.character.type ?? ""
        actualGenderLabel.text = viewModel.character.gender ?? ""
        actualSpeciesLabel.text = viewModel.character.species ?? ""
        
        let episodeNumbers = viewModel.character.episode?.map { $0.components(separatedBy: "/").last ?? "" } ?? []
        let episodeText = episodeNumbers.isEmpty ? "N/A" : episodeNumbers.joined(separator: ", ")
        
        let formattedEpisodes = episodeNumbers.map { "Episode: \($0)" }
        let formattedEpisodeText = formattedEpisodes.joined(separator: "\n")
        
        actualEpisodesLabel.text = formattedEpisodeText
        
        switch viewModel.character.status {
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
