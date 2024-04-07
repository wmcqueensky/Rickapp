//
//  EpisodeButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit

class EpisodeButton: BaseButton {
    
    override func setupViews() {
        super.setupViews()
        titleLabel?.font = .boldSystemFont(ofSize: 30)
        contentHorizontalAlignment = .left
        setImage(UIImage.getImage(.arrowIcon), for: .normal)
        tintColor = .white
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
    }
}
