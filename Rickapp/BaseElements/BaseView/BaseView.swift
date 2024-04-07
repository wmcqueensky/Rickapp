//
//  BaseView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit
import SnapKit

class BaseView: UIView {

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
