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
    
    func getCharacterById(_ characterId: Int) {
        AppNavigator.shared.navigate(to: MainRoutes.details(characterId: characterId), with: .push, animated: true)
    }
    
    func locationButtonTapped(_ locationUrl: String) {
        AppNavigator.shared.navigate(to: MainRoutes.location(url: locationUrl), with: .push, animated: true)
    }
    
    func bindToData() {}
}
