//
//  LocationDetailsViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 02/09/2023.
//

import Foundation
import Combine

class LocationDetailsViewModel: BaseViewModel {
    var locationPublisher = PassthroughSubject<Location, Never>()
    var url = ""
    
    override func bindToData() {
        super.bindToData()
        fetchLocation(url)
    }
    
    func fetchLocation(_ locationUrl: String) {
        CharacterService.shared.getLocation(url: locationUrl)
            .sink(receiveCompletion: { _ in} ) { [weak self] location in
                self?.locationPublisher.send(location)
            }
            .store(in: &cancellables)
    }
}
