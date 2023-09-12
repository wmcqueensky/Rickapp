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
    
    func getCharacterByUrl(url: String) -> AnyPublisher<Character, Error> {
        return request(for: .getElementbyUrl(url: url))
    }
    
    func getCharacterById(_ characterId: Int) -> AnyPublisher<Character, Error> {
        return request(for: .getSingleCharacterById(characterId: characterId))
    }
    
    func getFavouritesById(characterIds: [Int]) -> AnyPublisher<[Character], Error> {
        
        if characterIds.count == 0 {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        
        if characterIds.count == 1 {
            if let characterId = characterIds.first {
                return getCharacterById(characterId)
                    .map { [$0] }
                    .eraseToAnyPublisher()
            }
        }
        
        return request(for: .getManyCharactersById(characterIds: characterIds))
    }
    
    func getCharacterByUrls(characterUrls: [String]) -> AnyPublisher<[Character], Error> {
        if characterUrls.count == 0 {
            return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
        }

        if characterUrls.count == 1 {
            if let characterUrl = characterUrls.first {
                return getCharacterByUrl(url: characterUrl)
                    .map { [$0] }
                    .eraseToAnyPublisher()
            }
        }
        return request(for: .getManyCharactersByUrl(characterUrls: characterUrls))
    }
}
