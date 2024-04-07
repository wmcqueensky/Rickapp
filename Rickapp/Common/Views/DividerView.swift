//
//  DividerView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 05/09/2023.
//

import UIKit
import SnapKit

class DividerView: BaseView {

    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
