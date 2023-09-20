//
//  StatusView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 19/09/2023.
//

import UIKit
import SnapKit

enum Style {
    case alive
    case dead
    case unknown
}

class StatusView: BaseView {
    
    var style: Style = .alive {
        didSet {
            setupStyle()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        layer.cornerRadius = 6
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
    }
    
    private func setupStyle() {
        switch style {
        case .alive:
            backgroundColor = .green
        case .dead:
            backgroundColor = .red
        case .unknown:
            backgroundColor = .gray
        }
    }
    
    
    func animate() {
        transform = .identity
        alpha = 1
        
        switch style {
        case .alive:
            UIView.animate(withDuration: 0.5, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.alpha = 0.8
            })
        case .dead:
            UIView.animate(withDuration: 0.9, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 0.3)
                self.alpha = 0.8
            })
        case .unknown:
            UIView.animate(withDuration: 0.9, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.alpha = 0.1
            })
        }
    }
}
