//
//  FavouriteButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit
import SnapKit

class FavouriteButton: BaseButton {
    private let selectedImage = UIImage.getImage(.heartIconSelected)
    private let unselectedImage = UIImage.getImage(.heartIconUnselected)
    
    override var isSelected: Bool {
        didSet {
            setImage(isSelected ? selectedImage : unselectedImage, for: .normal)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        setImage(isSelected ? selectedImage : unselectedImage, for: .normal)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints({ make in
            make.width.height.equalTo(40)
        })
    }
}

