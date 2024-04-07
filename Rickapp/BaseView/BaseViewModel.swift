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
    var appNavigator: BaseNavigatorTestable = AppNavigator.shared

    func bindToData() {}
}

extension BaseViewModel: CharacterCardDelegate {
    func isDownloaded(_ episode: Episode) -> Bool {
        return downloadingManager.isDownloaded(episode: episode)
    }
    
    func isSubscribedUser() -> Bool {
        return !userNetworkManager.subscriptions.isEmpty
    }
    
    func isFinished(_ episode: Episode) -> Bool {
        audioProgressManager.isFinished(episode: episode)
    }
    
    func episodeTapped(episode: Episode) {
        appNavigator.navigate(to: PopupRoutes.episode(episode: episode), with: .modal)
    }
}
