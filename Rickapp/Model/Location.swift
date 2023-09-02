//
//  Location.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 29/08/2023.
//

import Foundation

struct Location: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String?
}
