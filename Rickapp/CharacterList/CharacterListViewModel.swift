//
//  CharacterListViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 22/08/2023.
//

import Foundation
import Combine

class CharacterListViewModel: BaseViewModel {
    private var isLoadingNextPage = false
    private var nextPage: String?
    var fetchCharacters = PassthroughSubject<[Character], Never>()
    var characterList = CharacterList()
    
    override func bindToData() {
        super.bindToData()
        getCharacters()
    }
    
    private func getCharacters() {
        
        CardService.shared.getCharacters()
            .sink(receiveCompletion: { _ in }) { [weak self] characterList in
                self?.nextPage = characterList.info?.next ?? ""
                self?.fetchCharacters.send(characterList.results ?? [])
            }
            .store(in: &cancellables)
    }
    
    func getNextCharactersPage() {
        guard !isLoadingNextPage, let nextPage = nextPage else { return }
        isLoadingNextPage = true
        if nextPage.isEmpty { return }
        CardService.shared.getNextCharactersPage(url: nextPage)
            .sink(receiveCompletion: { _ in }) { [weak self] characterList in
                guard let self = self else { return }
                self.characterList.results?.append(contentsOf: characterList.results ?? [])
                self.nextPage = characterList.info?.next ?? ""
                self.fetchCharacters.send(self.characterList.results ?? [])
                self.isLoadingNextPage = false
            }
            .store(in: &cancellables)
    }
    
    
    //    func getNextPage() {
    //        guard let nextPage = nextPage else { return }
    //        audioService.getNextEpisodesPage(url: nextPage)
    //            .sink { _ in } receiveValue: { [weak self] episodesList in
    //                guard let self = self else { return }
    //                self.episodes.append(contentsOf: episodesList.results ?? [])
    //                self.nextPage = episodesList.next
    //                self.isLoading.send(false)
    //            }.store(in: &subscriptionBag)
    //    }
    
    //        private func getNextEpisodesPage(url: String, completion: @escaping ([Episode])  -> Void) {
    //    self.audioService.getNextEpisodesPage(url: url)
    //        .sink { _ in } receiveValue: { [weak self] episodesList in
    //            guard let self = self else { return }
    //            completion(episodesList.results ?? [])
    //
    //            if let nextPage = episodesList.next {
    //                getNextEpisodesPage(url: nextPage, completion: completion)
    //            }
    //        }.store(in: &subscriptionBag)
    //}
    //
    //        private func getAllSeriesEpisodes(id: Int, completion: @escaping ([Character]) -> Void, completionNextPage: @escaping ([Episode]) -> Void) {
    //                .sink { _ in } receiveValue: { [weak self] episodesList in
    //                    guard let self = self else { return }
    //                    completion(episodesList.results ?? [])
    //
    //                    if let nextPage = episodesList.next {
    //                        getNextEpisodesPage(url: nextPage, completion: completionNextPage)
    //                    }
    //                }.store(in: &cancellables)
    //        }
}
