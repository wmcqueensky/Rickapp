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

    var screen: UIViewController {
        switch self {
        case .list:
            return buildListViewController()
        }
    }

    private func buildListViewController() -> UIViewController {
        let controller = CharacterListViewController()
        let viewModel = CharacterListViewModel()
        controller.viewModel = viewModel
        return controller
    }
}

