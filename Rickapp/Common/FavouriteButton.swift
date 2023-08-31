//
//  FavouriteButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit
import SnapKit

class FavouriteButton: BaseButton {
    
    override func setupViews() {
        super.setupViews()
        self.setImage(UIImage.getImage(.heartIconUnselected), for: .normal)
        self.setImage(UIImage.getImage(.heartIconSelected), for: .selected)
        self.addTarget(self, action: #selector(FavouriteButtonTapped), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints({ make in
            make.width.height.equalTo(40)
        })
    }
    
    @objc func FavouriteButtonTapped() {
        self.isSelected.toggle()
    }
}

