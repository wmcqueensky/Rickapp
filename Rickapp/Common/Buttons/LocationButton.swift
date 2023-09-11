//
//  LocationButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit

class LocationButton: BaseButton {
    
    override func setupViews() {
        super.setupViews()
        contentHorizontalAlignment = .left
        titleLabel?.font = .systemFont(ofSize: 20)
        setImage(UIImage.getImage(.arrowIcon), for: .normal)
        tintColor = .white
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
    }
}
