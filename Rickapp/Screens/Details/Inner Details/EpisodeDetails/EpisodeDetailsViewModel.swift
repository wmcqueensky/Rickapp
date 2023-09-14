//
//  EpisodeDetailsViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 03/09/2023.
//

import Foundation
import Combine

class EpisodeDetailsViewModel: BaseListViewModel {
    var episodePublisher = CurrentValueSubject<Episode, Never>(Episode())
    var url = ""
    
    override func bindToData() {
        super.bindToData()
        fetchEpisode(url)
    }
    
    private func fetchEpisode(_ episodeUrl: String) {
        CharacterService.shared.getEpisode(url: episodeUrl)
            .sink(receiveCompletion: { _ in } ) { [weak self] episode in
                self?.episodePublisher.send(episode)
                self?.fetchCharacters(episode.characters ?? [])
            }
            .store(in: &cancellables)
    }
}
