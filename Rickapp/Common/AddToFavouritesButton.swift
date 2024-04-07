//
//  AddToFavouritesButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit
import SnapKit

class AddToFavouritesButton: BaseButton {
    private let customImageView = UIImageView()
    
    override func setupViews() {
        super.setupViews()
        addTarget(self, action: #selector(addToFavouritesButtonTapped), for: .touchUpInside)
        self.setBackgroundImage(UIImage.getImage(.heartIconUnselected), for: .normal)
        self.setBackgroundImage(UIImage.getImage(.heartIconSelected), for: .selected)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addToFavouritesButtonTapped)))
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints({ make in
            make.width.height.equalTo(40)
        })
    }
    
    @objc private func addToFavouritesButtonTapped() {
        self.isSelected.toggle()
        self.isHighlighted = !self.isHighlighted
    }
}

