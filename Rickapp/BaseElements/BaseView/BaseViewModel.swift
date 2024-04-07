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
    var characterPublisher = CurrentValueSubject<Character, Never>(Character())
    
    func getCharacterById(_ characterId: Int) {
        AppNavigator.shared.navigate(to: MainRoutes.card(characterId: characterId), with: .push, animated: true)
    }
    
    func bindToData() {}
}
