//
//  CharacterList.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/08/2023.
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
