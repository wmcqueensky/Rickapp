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
    case getManyCharactersById(characterIds: [Int])
    case getManyCharactersByUrl(characterUrls: [String])
    case getFavouritesById(characterIds: [Int])
    
    var path: String {
        switch self {
        case .character:
            return "/character"
        case .getSingleCharacterById(let characterId):
            return "/character/\(characterId)"
        case .getManyCharactersById(let characterIds):
            let idsString = characterIds.map{ String($0) }.joined(separator: ",")
            
            return "/character/\(idsString)"
        case .getManyCharactersByUrl(let characterUrls):
            let characterNumbers = characterUrls.compactMap { urlString in
                if let characterNumber = urlString.split(separator: "/").last {
                    return String(characterNumber)
                }
                return nil
            }
            let idsString = characterNumbers.joined(separator: ",")
            return "/character/\(idsString)"
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
        case .character, .getSingleCharacterById, .getManyCharactersById, .getManyCharactersByUrl, .getFavouritesById, .getElementbyUrl:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .character, .getSingleCharacterById, .getManyCharactersById, .getManyCharactersByUrl, .getFavouritesById, .getElementbyUrl:
            return .requestPlain
        }
    }
}



