//
//  CharacterList.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/08/2023.
//

import Foundation

struct CharacterList: Codable {
    var info: CharacterListInfo?
    var results: [Character]?
}

struct CharacterListInfo: Codable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
}
