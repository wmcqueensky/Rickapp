//
//  CharacterCardViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/08/2023.
//

import Foundation
import Combine

class CharacterCardViewModel: BaseViewModel {
    var fetchCharacter = PassthroughSubject<Character, Never>()
    
    override func bindToData() {
        super.bindToData()
        CardService.shared.getCharacters()
            .sink(receiveCompletion: { _ in }) { [weak self] characterList in
                self?.fetchCharacter.send((characterList.results?.first)!)
            }
            .store(in: &cancellables)
    }
}
