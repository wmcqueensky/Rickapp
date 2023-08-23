//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Goodylabs on 18/08/2023.
//

import Foundation

struct Character: Codable {
    var name: String?
    var status: String?
    var species: String?
    var location: Location?
    var origin: Origin?
    var image: String?
}

import Foundation

struct CharacterResponse: Codable {
    var results: [Character]?
}
