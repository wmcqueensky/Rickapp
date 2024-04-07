//
//  CharacterDetailsViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//

import Foundation
import Combine

class CharacterDetailsViewModel: BaseListViewModel {
    var characterPublisher = CurrentValueSubject<Character, Never>(Character())
    var locationPublisher = PassthroughSubject<Location, Never>()
    var originPublisher = PassthroughSubject<Location, Never>()
    var id = 0
    
    override func bindToData() {
        super.bindToData()
        fetchCharacterById(id)
    }
    
    func fetchCharacterById(_ characterId: Int) {
        CharacterService.shared.getCharacterById(characterId)
            .sink(receiveCompletion: { _ in }) { [weak self] character in
                self?.characterPublisher.send(character)
                self?.fetchLocationForCharacter(character)
                self?.fetchOriginForCharacter(character)
            }
            .store(in: &cancellables)
    }
    
    private func fetchLocationForCharacter(_ character: Character) {
        guard let locationUrl = character.location?.url else { return }
        if locationUrl == "" { return }

        CharacterService.shared.getLocation(url: locationUrl)
            .sink(receiveCompletion: { _ in }) { [weak self] location in
                self?.locationPublisher.send(location)
            }
            .store(in: &cancellables)
    }
    
    private func fetchOriginForCharacter(_ character: Character) {
        guard let originUrl = character.origin?.url else { return }
        if originUrl == "" { return }

        CharacterService.shared.getLocation(url: originUrl)
            .sink(receiveCompletion: { _ in }) { [weak self] location in
                self?.originPublisher.send(location)
            }
            .store(in: &cancellables)
    }
    
    func manageFavourites(isSelected: Bool, characterId: Int) {
        isSelected ?
        FavouritesManager.shared.addToFavourites(characterId) :
        FavouritesManager.shared.removeFromFavourites(characterId)
    }
    
    func locationDetailsButtonTapped(_ locationUrl: String) {
        AppNavigator.shared.navigate(to: MainRoutes.location(url: locationUrl), with: .push, animated: true)
    }
    
    func episodeButtonTapped(_ episodeUrl: String) {
        AppNavigator.shared.navigate(to: MainRoutes.episode(url: episodeUrl), with: .push, animated: true)
    }
}
