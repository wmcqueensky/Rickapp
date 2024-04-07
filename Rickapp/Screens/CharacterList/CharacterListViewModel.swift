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
    var charactersPublisher = PassthroughSubject<[Character], Never>()
    var characters: [Character]? = []

    override func bindToData() {
        super.bindToData()
        CardService.shared.getCharacters()
            .sink(receiveCompletion: { _ in }) { [weak self] characterList in
                self?.nextPage = characterList.info?.next ?? ""
                self?.characters = characterList.results ?? []
                self?.charactersPublisher.send(self?.characters ?? [])
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
                self.characters?.append(contentsOf: characterList.results ?? [])
                self.nextPage = characterList.info?.next ?? ""
                self.charactersPublisher.send(self.characters ?? [])
                self.isLoadingNextPage = false
            }
            .store(in: &cancellables)
    }
    
    func getCharacterById(_ characterId: Int) {
        AppNavigator.shared.navigate(to: MainRoutes.card(characterId: characterId), with: .push, animated: true)
    }
}
