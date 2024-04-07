//
//  CharacterListViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 22/08/2023.
//

import Foundation
import Combine

class CharacterListViewModel: BaseViewModel {
    private var charactersSubject = PassthroughSubject<[Character], Never>()
    
    var charactersPublisher: AnyPublisher<[Character], Never> {
        return charactersSubject.eraseToAnyPublisher()
    }
    
    var characters: [Character] = [] {
        didSet {
            charactersSubject.send(characters)
        }
    }
    
    override func bindToData() {
        super.bindToData()
        
        CharacterService.shared.getCharacter()
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
