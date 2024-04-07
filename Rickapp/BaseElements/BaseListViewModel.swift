//
//  BaseListViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 13/09/2023.
//

import Foundation
import Combine

class BaseListViewModel: BaseViewModel {
    var charactersPublisher = CurrentValueSubject<[Character], Never>([])
    
    func getCharacterById(_ characterId: Int) {
        AppNavigator.shared.navigate(to: MainRoutes.details(characterId: characterId), with: .push, animated: true)
    }
    
    func fetchCharacters(_ characterUrls: [String]) {
        if characterUrls.isEmpty { return }
        CharacterService.shared.getCharacterByUrls(characterUrls: characterUrls)
            .sink(receiveCompletion: { _ in }) { [weak self] characters in
                self?.charactersPublisher.send(characters)
            }
            .store(in: &cancellables)
    }
    
    func isCharacterSelectedAsFavorite(_ characterId: Int) -> Bool {
        return FavouritesManager.shared.favourites.contains(characterId)
    }
    
    func toggleFavoriteStatus(for character: Character, isSelected: Bool) {
        guard let characterId = character.id else { return }
        
        if isSelected {
            FavouritesManager.shared.addToFavourites(characterId)
        } else {
            FavouritesManager.shared.removeFromFavourites(characterId)
        }
    }
}
