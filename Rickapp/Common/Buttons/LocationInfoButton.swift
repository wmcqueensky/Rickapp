//
//  LocationInfoButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit

class LocationInfoButton: BaseButton {
    
    override var isSelected: Bool {
        didSet {
            var image = isSelected ? UIImage.getImage(.bottomArrowIcon) : UIImage.getImage(.rightArrowIcon)
            setImage(image, for: .normal)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        contentHorizontalAlignment = .left
        titleLabel?.font = .systemFont(ofSize: 20)
        setImage(UIImage.getImage(.rightArrowIcon), for: .normal)
        tintColor = .white
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
    }
}
