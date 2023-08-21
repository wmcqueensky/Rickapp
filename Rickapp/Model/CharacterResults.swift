//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import Foundation

struct CharacterResults {
    let page: Int
    let characters: [Character]
}

extension CharacterResults: Decodable {
    private enum CharacterResultsCodingKeys: String, CodingKey {
        case page
        case characters
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterResultsCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        characters = try container.decode([Character].self, forKey: .characters)
    }
}
