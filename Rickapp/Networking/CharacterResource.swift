//
//  CharacterResource.swift
//  Rickapp
//
//  Created by Goodylabs on 23/08/2023.
//

import Foundation
import Moya

enum CharacterResource: TargetType {
    case character
    
    var baseURL: URL {
        let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "Base URL") as? String ?? ""
        return URL(string: baseUrlString)!
    }
    
    var headers: [String : String]? {
        return nil
    }
    
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
        case .character:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}


