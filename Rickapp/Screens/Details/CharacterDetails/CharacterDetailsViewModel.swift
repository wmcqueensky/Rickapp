//
//  CharacterDetailsViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//

import Foundation
import Combine

class CharacterDetailsViewModel: BaseViewModel {
    var characterPublisher = CurrentValueSubject<Character, Never>(Character())
    var id: Int = 0
    
    override func bindToData() {
        super.bindToData()
        fetchCharacterById(id)
    }
    
    func fetchCharacterById(_ characterId: Int) {
        CharacterService.shared.getCharacterById(characterId)
            .sink(receiveCompletion: { _ in }) { [weak self] character in
                self?.characterPublisher.send(character)
            }
            .store(in: &cancellables)
    }
    
    func manageFavourites(isSelected: Bool, characterId: Int) {
        isSelected ?
        FavouritesManager.shared.addToFavourites(characterId) :
        FavouritesManager.shared.removeFromFavourites(characterId)
    }
    
    func locationButtonTapped(_ locationUrl: String) {
        AppNavigator.shared.navigate(to: MainRoutes.location(url: locationUrl), with: .push, animated: true)
    }
    
    func episodeButtonTapped(_ episodeUrl: String) {
        AppNavigator.shared.navigate(to: MainRoutes.episode(url: episodeUrl), with: .push, animated: true)
    }
}
