//
//  CharacterResource.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Moya

enum CharacterResource: TargetType {
    
    case character
    case nextCharactersPage(url: String)
    case getLocation(url: String)
    case getCharacterById(characterId: Int)
    case getFavouritesById(characterIds: [Int])
    
    var path: String {
        switch self {
        case .character:
            return "/character"
        case .getCharacterById(let characterId):
            return "/character/\(characterId)"
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getLocation(let url):
            return URL(string: url)!
        case .nextCharactersPage(let url):
            return URL(string: url)!
        default:
            let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "Base URL") as? String ?? ""
            return URL(string: baseUrlString)!
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .character, .nextCharactersPage, .getCharacterById, .getFavouritesById, .getLocation:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .character, .nextCharactersPage, .getCharacterById, .getFavouritesById, .getLocation:
            return .requestPlain
        }
    }
}



