//
//  CharacterService.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Combine
import Moya

class CharacterService: BaseNetworkService<CharacterResource> {
    static let shared = CharacterService()
    
    func getCharacters() -> AnyPublisher<CharacterList, Error> {
        return request(for: .character)
    }
    
    func getNextCharactersPage(url: String) -> AnyPublisher<CharacterList, Error> {
        return request(for: .getElementbyUrl(url: url))
    }
    
    func getLocation(url: String) -> AnyPublisher<Location, Error> {
        return request(for: .getElementbyUrl(url: url))
    }
    
    func getEpisode(url: String) -> AnyPublisher<Episode, Error> {
        return request(for: .getElementbyUrl(url: url))
    }
    
    func getCharacterById(_ characterId: Int) -> AnyPublisher<Character, Error> {
        return request(for: .getSingleCharacterById(characterId: characterId))
    }
    
    func getFavouritesById(characterIds: [Int]) -> AnyPublisher<[Character], Error> {
        let favouriteCount = FavouritesManager.shared.favourites.count
        
        if favouriteCount == 0 {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        
        if favouriteCount == 1 {
            if let characterId = characterIds.first {
                return getCharacterById(characterId)
                    .map { [$0] }
                    .eraseToAnyPublisher()
            }
        }
        
        return request(for: .getManyCharactersById(characterIds: characterIds))
    }
}
