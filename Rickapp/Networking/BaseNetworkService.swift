//
//  BaseNetworkService.swift
//  Rickapp
//
//  Created by Goodylabs on 23/08/2023.
//

import Foundation
import Moya
import Combine
import CombineMoya

class BaseNetworkService<T: TargetType> {
    let provider = MoyaProvider<T>()
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func request<D: Decodable>(for type: T, atKeyPath: String? = nil) -> AnyPublisher<D, Error> {
        return provider.requestPublisher(type)
            .filterSuccessfulStatusCodes()
            .tryMap({ response in
                return try response.map(D.self, atKeyPath: atKeyPath, using: self.decoder)
            })
            .eraseToAnyPublisher()
    }
}

