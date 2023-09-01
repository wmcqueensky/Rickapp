//
//  FavouritesViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import Foundation
import Combine

class FavouriteListViewModel: BaseViewModel {
    var favouritesPublisher = CurrentValueSubject<[Character], Never>([])
    
    override func bindToData() {
        CardService.shared.getCharactersById(FavouritesManager.shared.favourites)
            .sink(receiveCompletion: { _ in }) { [weak self] characters in
                self?.favouritesPublisher.send(characters)
            }
            .store(in: &cancellables)
    }
}
