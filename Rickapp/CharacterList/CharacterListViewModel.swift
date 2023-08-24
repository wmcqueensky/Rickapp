//
//  CharacterListViewModel.swift
//  Rickapp
//
//  Created by Goodylabs on 22/08/2023.
//

import Foundation
import Combine

class CharacterListViewModel: BaseViewModel {
    @Published var characters: [Character] = []
    
    override func bindToData() {
        super.bindToData()
        
        CharacterService.shared.getCharacter()
//            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Network error: \(error)")
                }
            }) { [weak self] characters in
                self?.characters = characters
            }
            .store(in: &cancellables)
    }
}
