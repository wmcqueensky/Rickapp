//
//  CharacterService.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Combine
import Moya

class CardService: BaseNetworkService<CardResource> {
    static let shared = CardService()
    
    func getCharacters() -> AnyPublisher<CharacterList, Error> {
        return request(for: .character)
    }
    
    func getNextCharactersPage(url: String) -> AnyPublisher<CharacterList, Error> {
        return request(for: .nextCharactersPage(url: url))
    }
    
    func getFavouritesById(characterIds: [Int]) -> AnyPublisher<[Character], Error> {
        let requests = characterIds.map { characterId in
            return getCharacterById(characterId)
        }
        
        return Publishers.MergeMany(requests)
            .collect()
            .eraseToAnyPublisher()
    }
    
    func getCharacterById(_ characterId: Int) -> AnyPublisher<Character, Error> {
        return request(for: .getCharacterById(characterId: characterId))
    }
}
