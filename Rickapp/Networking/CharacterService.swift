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
        if FavouritesManager.shared.favourites.count < 2 {
            let requests = characterIds.map { characterId in
                return getCharacterById(characterId)
            }
            
            return Publishers.MergeMany(requests)
                .collect()
                .eraseToAnyPublisher()
        }
        return request(for: .getManyCharactersById(characterIds: characterIds))
    }
}
