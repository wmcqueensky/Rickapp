//
//  CharacterResource.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Moya

enum CardResource: TargetType {
    case character(page: Int)
    
    var path: String {
        switch self {
        case .character:
            return "/character"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .character:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .character(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }
}


