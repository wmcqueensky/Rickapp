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
}
