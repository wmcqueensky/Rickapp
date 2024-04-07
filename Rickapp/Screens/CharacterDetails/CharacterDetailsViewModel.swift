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
    
    init(_ characterId: Int) {
        super.init()
        self.fetchCharacterById(characterId)
    }
    
    func fetchCharacterById(_ characterId: Int) {
        CharacterService.shared.getCharacterById(characterId)
            .sink(receiveCompletion: { _ in }) { [weak self] character in
                self?.characterPublisher.send(character)
            }
            .store(in: &cancellables)
    }
}
