//
//  BaseViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Combine

class BaseViewModel: NSObject {
    var cancellables: Set<AnyCancellable> = []
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
    
    func bindToData() {}
}
