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
    
    func getCharactersById(_ characterIds: [Int]) -> AnyPublisher<[Character], Error> {
        return request(for: .getCharactersById(characterIds: characterIds))
    }
    
    func getNextCharactersPage(url: String) -> AnyPublisher<CharacterList, Error> {
        return request(for: .nextCharactersPage(url: url))
    }
    
    func getCharacterById(_ characterId: Int) -> AnyPublisher<Character, Error> {
        return request(for: .getCharacterById(characterId: characterId))
    }
}
