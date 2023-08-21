//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import Foundation

struct Character: Decodable {
    let name: String
    let status: String
    let species: String
    let location: Location
    let origin: Origin
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name, status, species, location, origin, image = "image"
    }
}

struct Location: Decodable {
    let name: String
}

struct Origin: Decodable {
    let name: String
}

struct CharacterResponse: Decodable {
    let results: [Character]
}
