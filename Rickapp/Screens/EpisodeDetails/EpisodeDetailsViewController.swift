//
//  EpisodeDetailsViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 03/09/2023.
//

import UIKit
import Combine
import SnapKit

class EpisodeDetailsViewController: BaseViewController<EpisodeDetailsViewModel> {
    private let episodeStackView = UIStackView()
    private let nameLabel = UILabel()
    private let airDateLabel = UILabel()
    private let actualAirDateLabel = UILabel()
    private let episodeNumberLabel = UILabel()
    private let actualEpisodeNumberLabel = UILabel()
    private let charactersLabel = UILabel()
    private let actualCharactersLabel = UILabel()
    private let scrollView = UIScrollView()
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.episodePublisher
            .sink { [weak self] episode in
                self?.setupData(episode)
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 0
        
        airDateLabel.text = "Date:"
        episodeNumberLabel.text = "Episode:"
        charactersLabel.text = "Characters:"
        
        view.setTextColorForLabels([airDateLabel, episodeNumberLabel, charactersLabel], color: .gray)
        view.setTextColorForLabels([nameLabel, actualAirDateLabel, actualEpisodeNumberLabel, actualCharactersLabel], color: .white)
        view.setFontForLabels([airDateLabel, actualAirDateLabel, episodeNumberLabel, actualEpisodeNumberLabel, charactersLabel, actualCharactersLabel], font: .systemFont(ofSize: 30))
        
        episodeStackView.backgroundColor = .darkGray
        episodeStackView.axis = .vertical
        episodeStackView.spacing = 3
        episodeStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        episodeStackView.addArrangedSubviews([nameLabel, airDateLabel, actualAirDateLabel, episodeNumberLabel, actualEpisodeNumberLabel, charactersLabel, actualCharactersLabel])
        
        view.backgroundColor = .darkGray
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(episodeStackView)
        view.addSubview(scrollView)
    }
    
    override func setupConstraints() {
        episodeStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.horizontalEdges.equalTo(view)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupData(_ episode: Episode) {
        nameLabel.text = episode.name ?? ""
        actualAirDateLabel.text = episode.airDate ?? ""
        actualEpisodeNumberLabel.text = episode.episode ?? ""
        
        let residentsNumbers = episode.characters?.map { $0.components(separatedBy: "/").last ?? "" } ?? []
        let residentsText = residentsNumbers.isEmpty ? "N/A" : residentsNumbers.joined(separator: ", ")
        
        let formattedResidents = residentsNumbers.map { "Resident: \($0)" }
        let formattedResidentText = formattedResidents.joined(separator: "\n")
        
        actualCharactersLabel.text = formattedResidentText
    }
}
