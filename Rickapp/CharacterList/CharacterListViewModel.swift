//
//  CharacterListViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 22/08/2023.
//

import Foundation
import Combine

class CharacterListViewModel: BaseViewModel {
    var fetchCharacters = PassthroughSubject<[Character], Never>()
    var characterList = CharacterList()
    
    var nextPage: String?
    var isLoading = false
    
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
        guard !isLoading, let nextPage = nextPage else { return }
        print("Fetching characters from next page: \(nextPage)")
        
        isLoading = true
        
        CardService.shared.getNextCharactersPage(url: nextPage)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                }
            }, receiveValue: { [weak self] characterList in
                guard let self = self else { return }
                self.characterList.results?.append(contentsOf: characterList.results ?? [])
                self.nextPage = characterList.info?.next ?? ""
                self.fetchCharacters.send(self.characterList.results ?? [])
                print("Fetched \(characterList.results?.count ?? 0) new characters")
            })
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
