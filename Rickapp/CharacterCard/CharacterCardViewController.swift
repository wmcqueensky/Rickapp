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
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 2
        
        statusLabel.textColor = .white
        statusLabel.font = .systemFont(ofSize: 20)

        statusView.layer.cornerRadius = 5
        
        statusStackView.axis = .horizontal
        statusStackView.spacing = 6
        statusStackView.addArrangedSubviews([statusView, statusLabel])
        statusStackView.alignment = .center
        
        locationLabel.text = "Last known location:"
        locationLabel.textColor = .gray
        locationLabel.font = .systemFont(ofSize: 20)
        
        actualLocationLabel.textColor = .white
        actualLocationLabel.font = .systemFont(ofSize: 20)
        
        originLabel.text = "First seen in:"
        originLabel.textColor = .gray
        originLabel.font = .systemFont(ofSize: 20)

        actualOriginLabel.textColor = .white
        actualOriginLabel.font = .systemFont(ofSize: 20)

        typeLabel.text = "Type:"
        typeLabel.textColor = .gray
        typeLabel.font = .systemFont(ofSize: 20)

        actualTypeLabel.textColor = .white
        actualTypeLabel.font = .systemFont(ofSize: 20)

        genderLabel.text = "Gender:"
        genderLabel.textColor = .gray
        genderLabel.font = .systemFont(ofSize: 20)

        actualGenderLabel.textColor = .white
        actualGenderLabel.font = .systemFont(ofSize: 20)

        speciesLabel.text = "Species:"
        speciesLabel.textColor = .gray
        speciesLabel.font = .systemFont(ofSize: 20)

        actualSpeciesLabel.textColor = .white
        actualSpeciesLabel.font = .systemFont(ofSize: 20)

        episodesLabel.text = "Episodes:"
        episodesLabel.textColor = .gray
        episodesLabel.font = .systemFont(ofSize: 20)

        actualEpisodesLabel.textColor = .white
        actualEpisodesLabel.numberOfLines = 0
        actualEpisodesLabel.font = .systemFont(ofSize: 25)

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
        characterStackView.addArrangedSubviews([nameLabel, statusStackView, locationLabel, actualLocationLabel, originLabel, actualOriginLabel, typeLabel, actualTypeLabel, genderLabel, actualGenderLabel, speciesLabel, actualSpeciesLabel, episodesLabel, actualEpisodesLabel,UIView()])
        characterStackView.setCustomSpacing(9, after: characterImageView)
        characterStackView.setCustomSpacing(20, after: statusStackView)
        characterStackView.setCustomSpacing(20, after: actualLocationLabel)
        characterStackView.setCustomSpacing(20, after: actualOriginLabel)
        characterStackView.setCustomSpacing(20, after: actualTypeLabel)
        characterStackView.setCustomSpacing(20, after: actualGenderLabel)
        characterStackView.setCustomSpacing(20, after: actualSpeciesLabel)
        characterStackView.setCustomSpacing(16, after: actualEpisodesLabel)
        characterStackView.setEdgeInsets(top: 7, left: 15, bottom: 0, right:15)
        
        view.backgroundColor = .backgroundGray
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(characterImageView)
        scrollView.addSubview(characterStackView)
        view.addSubview(scrollView)
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
        characterImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.top.equalTo(scrollView)
            make.height.equalTo(450)
        }
        
        characterStackView.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom)
            make.horizontalEdges.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        statusView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
    }
    
    override func setupData() {
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
}
