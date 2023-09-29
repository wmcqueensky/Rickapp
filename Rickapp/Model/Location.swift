//
//  Location.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 29/08/2023.
//

import Foundation

struct LocationList: Codable {
    var info: Info?
    var results: [Location]?
}

struct Origin: Codable {
    var name: String?
    var url: String?
}

struct Location: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String?
}
