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
    private var currentPage = 1
    
    var isLoadingNextPage = false
    
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
        getCharacters(pageNumber: currentPage)
    }
    
    private func getCharacters(pageNumber: Int) {
        
        CardService.shared.getCharacter(page: pageNumber)
            .sink(receiveCompletion: { _ in }) { [weak self] characters in
                self?.isLoadingNextPage = false
                self?.characters.append(contentsOf: characters)
            }
            .store(in: &cancellables)
    }
    
    func getNextPage() {
        guard isLoadingNextPage else {
            return
        }
        
        currentPage += 1
        getCharacters(pageNumber: currentPage)
    }
}
