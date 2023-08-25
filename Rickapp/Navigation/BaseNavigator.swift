//
//  BaseNavigator.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//

import Foundation
import UIKit

public enum TransitionType {
    case overFullScreen
    case fullScreenModal
    case modal
    case push
    case reset
    case changeRoot
}

protocol BaseNavigatorTestable {
    var rootViewController: UINavigationController? { get set }
    var currentViewController: UIViewController? { get }
    var currentEmbeddedNavigationController: UINavigationController? { get set }
    
    func popEmbedded(animated: Bool, completion: (() -> Void)?)
    func pushEmbedded(to route: Route, animated: Bool)
    func popToRootEmbedded(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func navigate(to route: Route, with transition: TransitionType, animated: Bool, completion: (() -> Void)?)
    func popToRoot(animated: Bool)
    func pop(animated: Bool)
}

extension BaseNavigatorTestable {
    func navigate(to route: Route, with transition: TransitionType, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigate(to: route, with: transition, animated: animated, completion: completion)
    }
    
    func popToRoot(animated: Bool = true) {
        popToRoot(animated: animated)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    func pop(animated: Bool = true) {
        pop(animated: animated)
    }
    
    func pushEmbedded(to route: Route, animated: Bool = true) {
        pushEmbedded(to: route, animated: animated)
    }
    
    func popEmbedded(animated: Bool = true, completion: (() -> Void)? = nil) {
        popEmbedded(animated: animated, completion: completion)
    }
    
    func popToRootEmbedded(animated: Bool = true) {
        popToRootEmbedded(animated: animated)
    }
}

class BaseNavigator: BaseNavigatorTestable {
    var rootViewController: UINavigationController?
    var currentEmbeddedNavigationController: UINavigationController?
    var currentViewController: UIViewController? {
        return rootViewController?.visibleViewController ?? rootViewController?.topViewController
    }

    public required init(with route: Route) {
        rootViewController = route.screen.embedInNavigationController()
    }
    
    open func pushEmbedded(to route: Route, animated: Bool = true) {
        let viewController = route.screen
        route.transitionConfigurator?(currentViewController, viewController)
        currentEmbeddedNavigationController?.pushViewController(viewController, animated: animated)
    }

    open func popEmbedded(animated: Bool = true, completion: (() -> Void)? = nil) {
        currentEmbeddedNavigationController?.popViewController(
            animated: animated
        )
    }
    
    open func popToRootEmbedded(animated: Bool = true) {
        currentEmbeddedNavigationController?.popToRootViewController(animated: animated)
    }

    open func popEmbedded(to viewController: UIViewController, animated: Bool = true) {
        currentEmbeddedNavigationController?.popToViewController(
            viewController, animated: animated
        )
    }

    open func navigate(to route: Route, with transition: TransitionType, animated: Bool = true, completion: (() -> Void)? = nil) {
        let viewController = route.screen
        switch transition {
        case .overFullScreen:
            route.transitionConfigurator?(currentViewController, viewController)
            viewController.modalPresentationStyle = .overFullScreen
            currentViewController?.present(viewController, animated: animated, completion: completion)
        case .fullScreenModal:
            route.transitionConfigurator?(currentViewController, viewController)
            viewController.modalPresentationStyle = .fullScreen
            currentViewController?.present(viewController, animated: animated, completion: completion)
        case .modal:
            route.transitionConfigurator?(currentViewController, viewController)
            currentViewController?.present(viewController, animated: animated, completion: completion)
        case .push:
            route.transitionConfigurator?(currentViewController, viewController)
            rootViewController?.pushViewController(viewController, animated: animated)
        case .reset:
            route.transitionConfigurator?(nil, viewController)
            rootViewController?.setViewControllers([viewController], animated: animated)
        case .changeRoot:
            let navigation = viewController.embedInNavigationController()
            UIApplication.shared.keyWindow?.rootViewController = navigation
            rootViewController = navigation
        }
    }

    open func navigate(to router: BaseNavigator, animated: Bool, completion: (() -> Void)?) {
        guard let viewController = router.rootViewController else {
            assert(false, "Navigator does not have a root view controller")
            return
        }
        currentViewController?.present(viewController, animated: animated, completion: completion)
    }

    open func pop(animated: Bool = true) {
        rootViewController?.popViewController(animated: animated)
    }

    open func popToRoot(animated: Bool = true) {
        rootViewController?.popToRootViewController(animated: animated)
    }

    open func popTo(index: Int, animated: Bool = true) {
        guard
            let viewControllers = rootViewController?.viewControllers,
            viewControllers.count > index
            else { return }
        let viewController = viewControllers[index]
        rootViewController?.popToViewController(viewController, animated: animated)
    }

    open func popTo(route: Route, animated: Bool = true) {
        guard
            let viewControllers = rootViewController?.viewControllers,
            let viewController = viewControllers.first(where: {
                type(of: $0) == type(of: route.screen)
            })
            else { return }
        rootViewController?.popToViewController(viewController, animated: true)
    }

    open func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        currentViewController?.dismiss(animated: animated, completion: completion)
    }
    
    open func isPopRoutePresented(route: Route) -> Bool {
        let viewControllers = rootViewController?.viewControllers
        let viewController = viewControllers?.first(where: {
            type(of: $0) == type(of: route.screen)
        })
        return viewController != nil
    }
    
    open func isControllerPresented(screen: UIViewController.Type) -> Bool {
        let viewControllers = rootViewController?.viewControllers
        let viewController = viewControllers?.first(where: {
            type(of: $0) == screen
        })
        return viewController != nil
    }
}

public protocol Route {
    var screen: UIViewController { get }

    /**
     Configuration callback executed just before pushing/presenting modally.
     Use this to set up any custom transition delegate, presentationStyle, etc.
     */
    var transitionConfigurator: TransitionConfigurator? { get }
    typealias TransitionConfigurator = (_ sourceVc: UIViewController?, _ destinationVc: UIViewController) -> Void
}

public extension Route {
    var transitionConfigurator: TransitionConfigurator? {
        return nil
    }
}

public extension UIViewController {
    func embedInNavigationController() -> UINavigationController {
        if let navigation = self as? UINavigationController {
            return navigation
        }
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
}
