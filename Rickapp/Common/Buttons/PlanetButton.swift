//
//  CircleButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 12/09/2023.
//

import UIKit

class PlanetButton: BaseButton {
    
    override func setupViews() {
        super.setupViews()
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
}
