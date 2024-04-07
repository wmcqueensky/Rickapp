//
//  FavouritesManager.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 01/09/2023.
//

import Foundation
import Combine

class FavouritesManager {
    static let shared = FavouritesManager()
    
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
        if let index = favourites.firstIndex(of: characterId) {
            favourites.remove(at: index)
        }
    }
}
