//
//  StatusView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 19/09/2023.
//

import UIKit

enum Style {
    case big
    case small
}

class StatusView: BaseView {
    
    var style: Style = .big {
        didSet {
            setupViews()
            setupConstraints()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        switch style {
        case .big:
            layer.cornerRadius = 6
        case .small:
            layer.cornerRadius = 5
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        switch style {
        case .big:
            self.snp.makeConstraints { make in
                make.width.height.equalTo(12)
            }
        case .small:
            self.snp.makeConstraints { make in
                make.width.height.equalTo(10)
            }
        }
    }
    
    
    func animate() {
        transform = .identity
        alpha = 1

        guard let backgroundColor = backgroundColor else { return }
        switch backgroundColor {
        case .green:
            UIView.animate(withDuration: 0.5, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.alpha = 0.8
            })
        case .red:
            UIView.animate(withDuration: 0.9, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 0.3)
                self.alpha = 0.8
            })
        default:
            UIView.animate(withDuration: 0.9, delay: 0.2, options: [.autoreverse, .repeat], animations: {
                self.alpha = 0.1
            })
        }
    }
}
