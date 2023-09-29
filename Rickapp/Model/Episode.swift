//
//  Episode.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 03/09/2023.
//

import Foundation

struct EpisodeList: Codable {
    var info: Info?
    var results: [Episode]?
}

struct Episode: Codable {
    var id: Int?
    var name: String?
    var airDate: String?
    var episode: String?
    var characters: [String]?
    var url: String?
}
