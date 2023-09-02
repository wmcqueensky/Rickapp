//
//  MainROutes.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 28/08/2023.
//

import Foundation
import UIKit

enum MainRoutes: Route {
    case details(characterId: Int)
    case location(url: String)
    case menu
    
    var screen: UIViewController {
        switch self {
        case .details(let character):
            return buildCharacterDetailsViewController(characterId: character)
        case .menu:
            return buildMenuViewController()
        case .location(let url):
            return buildLocationDetailsViewController(locationUrl: url)
        }
    }
    
    private func buildCharacterDetailsViewController(characterId: Int) -> UIViewController {
        let controller = CharacterDetailsViewController()
        let viewModel = CharacterDetailsViewModel(characterId)
        controller.viewModel = viewModel
        return controller
    }
    
    private func buildLocationDetailsViewController(locationUrl: String) -> UIViewController {
        let controller = LocationDetailsViewController()
        let viewModel = LocationDetailsViewModel(locationUrl)
        controller.viewModel = viewModel
        return controller
    }
    
    private func buildMenuViewController() -> UIViewController {
        let controller = MenuViewController()
        return controller
    }
}

