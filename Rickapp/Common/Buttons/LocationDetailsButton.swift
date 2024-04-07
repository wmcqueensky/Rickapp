//
//  LocationDetailsButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 19/09/2023.
//

import UIKit

class LocationDetailsButton: BaseButton {
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .kiwiGreen
        setTitleColor(.white, for: .normal)
        setTitle("See more", for: .normal)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(90)
        }
    }
}
