//
//  LocationInfoButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit
import SnapKit

enum LocationInfoButtonStyle {
    case known
    case unknown
}

class LocationInfoButton: BaseButton {
    
    override var isSelected: Bool {
        didSet {
            let image = isSelected ? UIImage.getImage(.bottomArrowIcon) : UIImage.getImage(.rightArrowIcon)
            setImage(image, for: .normal)
        }
    }
    
    var style: LocationInfoButtonStyle = .known {
        didSet {
            setupStyle()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        contentHorizontalAlignment = .left
        titleLabel?.font = .systemFont(ofSize: 20)
        tintColor = .white
        setImage(UIImage.getImage(.rightArrowIcon), for: .normal)
    }
    
    func setupStyle() {
        switch style {
        case .known:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        case .unknown:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
            isEnabled = false
            setImage(.none, for: .normal)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
    }
}
