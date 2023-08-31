//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 18/08/2023.
//

import Foundation

struct CharacterList: Codable {
    var info: Info?
    var results: [Character]?
}

struct Info: Codable {
    var count: Int?
    var pages: Int?
    var next: String?
}

struct Character: Codable, Equatable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var location: Location?
    var origin: Origin?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Origin: Codable {
    var name: String?
}
