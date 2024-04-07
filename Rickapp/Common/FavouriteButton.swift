//
//  FavouriteButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit

class FavouriteButton: BaseButton {
    private let selectedImage = UIImage.getImage(.heartIconSelected)
    private let unselectedImage = UIImage.getImage(.heartIconUnselected)
    
    override var isSelected: Bool {
        didSet {
            setImage(isSelected ? selectedImage : unselectedImage, for: .normal)
            tintColor = isSelected ? UIColor.red : UIColor.white
        }
    }
}
