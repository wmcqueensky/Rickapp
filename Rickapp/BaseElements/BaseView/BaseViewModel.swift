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
    
    func bindToData() {}
}