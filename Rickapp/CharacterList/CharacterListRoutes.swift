//
//  CharacterListRoutes.swift
//  Tortoise
//
//  Created by Goodylabs on 23/08/2023.
//

import Foundation
import UIKit

enum CharacterListRoutes: Route {
    case characters
    
    var screen: UIViewController {
        switch self {
        case .characters:
            return buildCharacterViewController()
        }
    }
    
    private func buildCharacterViewController() -> UIViewController {
        let controller = CharacterListViewController()
        let viewModel = CharacterListViewModel()
        controller.viewModel = viewModel
        return controller
    }
}
