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
    
    func getCharacter(page: Int) -> AnyPublisher<[Character], Error> {
        return request(for: .character(page: page), atKeyPath: "results")
    }
}
