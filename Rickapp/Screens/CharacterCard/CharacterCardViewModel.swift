//
//  CharacterCardViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//

import Foundation
import Combine

class CharacterCardViewModel: BaseViewModel {
    var characterPublisher = PassthroughSubject<Character, Never>()
    var character = Character()

    
    func fetchCharacterById(_ characterId: Int) {
        CardService.shared.getCharacterById(characterId)
            .sink(receiveCompletion: { _ in }) { [weak self] character in
                self?.character = character
                self?.characterPublisher.send(self?.character ?? Character())
            }
            .store(in: &cancellables)
    }
}
