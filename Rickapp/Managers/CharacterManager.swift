//
//  CharacterManager.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 01/09/2023.
//

import Foundation
import Combine

class CharacterManager {
    static let shared = CharacterManager()
    var favouritesPasser = PassthroughSubject<[Character], Error>()
    var favourites: [Int] {
        get {
            return UserDefaults.standard.array(forKey: "favoriteCharacterIds") as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "favoriteCharacterIds")
        }
    }
    
    func addToFavourites(_ characterId: Int) {
        favourites.append(characterId)
    }
    
    func removeFromFavourites(_ characterId: Int) {
        favourites.removeAll { $0 == characterId }
    }
}
