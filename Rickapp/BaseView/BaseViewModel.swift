//
//  BaseViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import Combine

class BaseViewModel: NSObject {
    var cancellables: Set<AnyCancellable> = []
//    var appNavigator: BaseNavigatorTestable = BaseNavigator.shared
    
    func bindToData() {}
    
//    private func getNextCharactersPage(url: String, completion: @escaping ([Character])  -> Void) {
//        CardService.shared.getNextCharactersPage(url: url)
//            .sink { _ in } receiveValue: { [weak self] characterList in
//                guard let self = self else { return }
//                completion(characterList.results ?? [])
//
//                if let nextPage = characterList.info?.next {
//                    getNextCharactersPage(url: nextPage, completion: completion)
//                }
//            }.store(in: &cancellables)
//    }
}
