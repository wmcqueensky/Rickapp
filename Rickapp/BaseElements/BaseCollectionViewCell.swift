//
//  BaseCollectionViewCell.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 13/09/2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {}
    func setupConstraints() {}
}

