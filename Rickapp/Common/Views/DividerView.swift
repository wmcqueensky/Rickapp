//
//  DividerView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import SnapKit

class DividerView: BaseView {
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white.withAlphaComponent(0.5)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
