//
//  CharacterCardViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//

import Foundation
import Combine

class CharacterCardViewModel: BaseViewModel {
    func fetchCharacterById(_ characterId: Int) {
        CardService.shared.getCharacterById(characterId)
            .sink(receiveCompletion: { _ in }) { [weak self] character in
                self?.characterPublisher.send(character)
            }
            .store(in: &cancellables)
    }
}
