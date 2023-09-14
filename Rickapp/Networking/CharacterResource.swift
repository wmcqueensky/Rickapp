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
    case getElementbyUrl(url: String)
    case getSingleCharacterById(characterId: Int)
    case getManyCharactersById(characterIds: String)
    case getFavouritesById(characterIds: [Int])
    
    var path: String {
        switch self {
        case .character:
            return "/character"
        case .getSingleCharacterById(let characterId):
            return "/character/\(characterId)"
        case .getManyCharactersById(let characterIds):
            return "/character/\(characterIds)"
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getElementbyUrl(let url):
            return URL(string: url)!
        default:
            let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "Base URL") as? String ?? ""
            return URL(string: baseUrlString)!
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .character, .getSingleCharacterById, .getManyCharactersById, .getFavouritesById, .getElementbyUrl:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .character, .getSingleCharacterById, .getManyCharactersById, .getFavouritesById, .getElementbyUrl:
            return .requestPlain
        }
    }
}



