//
//  MainROutes.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 28/08/2023.
//

import Foundation
import UIKit

enum MainRoutes: Route {
    case card(characterId: Int)
    case menu
    
    var screen: UIViewController {
        switch self {
        case .card(let character):
            return buildCharacterCardViewController(characterId: character)
        case .menu:
            return buildMenuViewController()
        }
    }
    
    private func buildCharacterCardViewController(characterId: Int) -> UIViewController {
        let controller = CharacterCardViewController()
        let viewModel = CharacterCardViewModel()
        viewModel.fetchCharacterById(characterId)
        controller.viewModel = viewModel
        return controller
    }
    
    private func buildMenuViewController() -> UIViewController {
        let controller = MenuViewController()
        return controller
    }
}

