//
//  EpisodeDetailsViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 03/09/2023.
//

import Foundation
import Combine

class EpisodeDetailsViewModel: BaseViewModel {
    var episodePublisher = PassthroughSubject<Episode, Never>()
    var url = ""
    
    override func bindToData() {
        super.bindToData()
        fetchLocation(url)
    }
    
    func fetchLocation(_ episodeUrl: String) {
        CharacterService.shared.getEpisode(url: episodeUrl)
            .sink(receiveCompletion: { _ in} ) { [weak self] episode in
                self?.episodePublisher.send(episode)
            }
            .store(in: &cancellables)
    }
}
