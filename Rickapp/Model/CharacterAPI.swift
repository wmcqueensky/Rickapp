//
//  CharacterAPI.swift
//  Rickapp
//
//  Created by Goodylabs on 21/08/2023.
//

import Foundation
import Moya

enum CharacterAPI{
    case name(name:String)
    case status(status:String)
    case species(species:String)
    case location(location:Location)
    case origin(origin:Origin)
    case image(image:String)
    case page(page: Int)
}

extension CharacterAPI: TargetType {
    var path: String {
        switch self {
        case .name(let name):
            return "/character/?name=\(name)"
        case .status(let status):
            return "/character/?status=\(status)"
        case .species(let species):
            return "/character/?species=\(species)"
        case .location(let location):
            return "/character/?location.name=\(location.name)"
        case .origin(let origin):
            return "/character/?origin.name=\(origin.name)"
        case .image(let image):
            return "/character/?image=\(image)"
        case .page(let page):
            return "/character?page=\(page)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .name, .status, .species, .location, .origin, .image, .page:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com/api") else { fatalError("baseUrl could not be configured")}
        return url
    }
}
