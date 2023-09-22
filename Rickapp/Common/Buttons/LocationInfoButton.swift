//
//  LocationInfoButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit
import SnapKit

class LocationInfoButton: BaseButton {
    
    override var isSelected: Bool {
        didSet {
            let image = isSelected ? UIImage.getImage(.bottomArrowIcon) : UIImage.getImage(.rightArrowIcon)
            setImage(image, for: .normal)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        layer.cornerRadius = 10
        contentHorizontalAlignment = .left
        titleLabel?.font = .systemFont(ofSize: 20)
        setImage(UIImage.getImage(.rightArrowIcon), for: .normal)
        tintColor = .white
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
    }
}
