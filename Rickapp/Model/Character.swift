//
//  CharacterCard.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 18/08/2023.
//

import Foundation

struct Character: Codable {
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
}

struct Location: Codable {
    var name: String?
}

struct Origin: Codable {
    var name: String?
}
