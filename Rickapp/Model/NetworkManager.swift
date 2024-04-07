//
//  NetworkManager.swift
//  Rickapp
//
//  Created by Goodylabs on 21/08/2023.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<CharacterAPI> { get }
    func getNewCharacters(page: Int, completion: @escaping ([Character])->())
}

struct NetworkManager: Networkable {
    var provider = MoyaProvider<CharacterAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getNewCharacters(page: Int, completion: @escaping ([Character]) -> ()) {
        provider.request(.page(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(CharacterResults.self, from: response.data)
                    completion(results.characters)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
