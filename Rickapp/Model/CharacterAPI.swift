////
////  CharacterAPI.swift
////  Rickapp
////
////  Created by Goodylabs on 21/08/2023.
////
//
//import Foundation
//import Moya
//
//enum CharacterAPI {
//    case page(page: Int)
//}
//
//extension CharacterAPI: TargetType {
//    var path: String {
//        switch self {
//        case .page(let page):
//            return "/character?page=\(page)"
//        }
//    }
//    
//    var method: Moya.Method {
//        return .get
//    }
//    
//    var task: Moya.Task {
//        switch self {
//        case .page:
//            return .requestPlain
//        }
//    }
//    
//    var headers: [String : String]? {
//        return ["Content-Type": "application/json"]
//    }
//    
//    var baseURL: URL {
//        guard let url = URL(string: "https://rickandmortyapi.com/api") else { fatalError("baseUrl could not be configured")}
//        return url
//    }
//}
