//
//  FavouritesViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import Foundation
import Combine

class FavouriteListViewModel: BaseViewModel {
    private var isLoadingNextPage = false
    private var nextPage: String?
    private var previousPage: String?
    var charactersPublisher = CurrentValueSubject<[Character], Never>([])
    var isFollowed = PassthroughSubject<Bool, Never>()

    override func bindToData() {
        super.bindToData()
        
    }
    
    func getNextCharactersPage() {
        guard !isLoadingNextPage, let nextPage = nextPage else { return }
        if nextPage.isEmpty { return }
        isLoadingNextPage = true
        CardService.shared.getNextCharactersPage(url: nextPage)
            .sink(receiveCompletion: { _ in }) { [weak self] characterList in
                guard let self = self else { return }
                let existingCharacters = self.charactersPublisher.value
                let newCharacters = characterList.results ?? []
                self.charactersPublisher.send(existingCharacters + newCharacters)
                self.nextPage = characterList.info?.next ?? ""
                self.isLoadingNextPage = false
            }
            .store(in: &cancellables)
    }
    
    func getCharacterById(_ characterId: Int) {
        AppNavigator.shared.navigate(to: MainRoutes.card(characterId: characterId), with: .push, animated: true)
    }
}
