//
//  MainROutes.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 28/08/2023.
//

import Foundation
import UIKit

enum MainRoutes: Route {
    case list
    case card(character: Character)
    
    var screen: UIViewController {
        switch self {
        case .list:
            return buildCharacterListViewController()
        case .card(let character):
            return buildCharacterCardViewController(character: character)
        }
    }
    
    private func buildCharacterListViewController() -> UIViewController {
        let controller = CharacterListViewController()
        let viewModel = CharacterListViewModel()
        controller.viewModel = viewModel
        return controller
    }
    
    private func buildCharacterCardViewController(character: Character) -> UIViewController {
        let controller = CharacterCardViewController()
        let viewModel = CharacterCardViewModel()
        viewModel.fetchSelectedCharacter(character)
        controller.viewModel = viewModel
        return controller
    }
}

