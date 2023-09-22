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
    private let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.episodePublisher
            .sink { [weak self] episode in
                self?.setupData(episode)
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.charactersPublisher
            .sink { [weak self] characters in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        super.setupViews()
        nameLabel.font = .boldSystemFont(ofSize: 44)
        nameLabel.numberOfLines = 0
        
        airDateLabel.text = "Date:"
        episodeNumberLabel.text = "Episode:"
        charactersLabel.text = "Characters:"
        
        view.setTextColorForLabels([airDateLabel, episodeNumberLabel, charactersLabel], color: .gray)
        view.setTextColorForLabels([nameLabel, actualAirDateLabel, actualEpisodeNumberLabel], color: .white)
        view.setFontForLabels([airDateLabel, actualAirDateLabel, episodeNumberLabel, actualEpisodeNumberLabel, charactersLabel], font: .boldSystemFont(ofSize: 24))
        
        episodeStackView.backgroundColor = .darkGray
        episodeStackView.axis = .vertical
        episodeStackView.spacing = 3
        episodeStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        episodeStackView.addArrangedSubviews([nameLabel, airDateLabel, actualAirDateLabel, episodeNumberLabel, actualEpisodeNumberLabel, charactersLabel])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTileTableViewCell.self, forCellReuseIdentifier: String(describing: CharacterTileTableViewCell.self))
        tableView.tableHeaderView = episodeStackView
        tableView.backgroundColor = .backgroundGray
        tableView.showsVerticalScrollIndicator = false
        
        
        view.backgroundColor = .darkGray
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        episodeStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(tableView)
            make.horizontalEdges.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    private func setupData(_ episode: Episode) {
        nameLabel.text = "\"\(episode.name ?? "")\""
        actualAirDateLabel.text = episode.airDate ?? ""
        actualEpisodeNumberLabel.text = episode.episode ?? ""
    }
}

extension EpisodeDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characterId = viewModel.charactersPublisher.value[indexPath.row].id else { return }
        viewModel.getCharacterById(characterId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodePublisher.value.characters?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTileTableViewCell.self)) as? CharacterTileTableViewCell else { return UITableViewCell() }

        cell.character = viewModel.charactersPublisher.value[indexPath.row]
        cell.animateStatusView()
        cell.animateSpeciesImageView()
        
        return cell
    }
}

