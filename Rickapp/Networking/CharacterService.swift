//
//  CharacterService.swift
//  Rickapp
//
//  Created by Goodylabs on 23/08/2023.
//

import Foundation
import Combine
import Moya

class CharacterService: BaseNetworkService<CharacterResource> {
    static let shared = CharacterService()
    
    func getCharacter() -> AnyPublisher<[Character], Error> {
        return request(for: .character, atKeyPath: "results")
    }
}
