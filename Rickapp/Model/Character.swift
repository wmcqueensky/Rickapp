//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import Foundation

struct Character {
    let name: String
    let status: String
    let species: String
    let location: Location
    let origin: Origin
    let image: String
}

extension Character: Decodable {
    enum CharacterCodingKeys: String, CodingKey {
        case name
        case status
        case species
        case location
        case origin
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterCodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        location = try container.decode(Location.self, forKey: .location)
        origin = try container.decode(Origin.self, forKey: .origin)
        image = try container.decode(String.self, forKey: .image)
    }
}
