//
//  CharacterResource.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Moya

enum CardResource: TargetType {
    
    case character
    case nextCharactersPage(url: String)
    
    var path: String {
        switch self {
        case .character:
            return "/character"
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        switch self {
        case .nextCharactersPage(let url):
            return URL(string: url)!
        default:
            let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "Base URL") as? String ?? ""
            return URL(string: baseUrlString)!
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .character, .nextCharactersPage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .character, .nextCharactersPage:
            return .requestPlain
        }
    }
}


