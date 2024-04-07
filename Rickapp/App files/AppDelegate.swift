//
//  AppDelegate.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 18/08/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationBar()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        let backButtonAppearance = UIBarButtonItemAppearance()
        let backButtonImage = UIImage.getImage(.backButton).withRenderingMode(.alwaysTemplate)

        backButtonAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        navigationBarAppearance.backButtonAppearance = backButtonAppearance
        
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = .gray
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

