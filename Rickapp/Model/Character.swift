//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import Foundation

struct Character: Codable {
    let name: String?
    let status: String?
    let species: String?
    let location: Location?
    let origin: Origin?
    let image: String?
}

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]?
}
