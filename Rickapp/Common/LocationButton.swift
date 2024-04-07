//
//  LocationButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 02/09/2023.
//

import UIKit

class LocationButton: UIButton {
    
    private var originalTextColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        titleLabel?.font = .systemFont(ofSize: 20)
        
        originalTextColor = titleLabel?.textColor
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        sendActions(for: .touchUpInside)
        
        UIView.animate(withDuration: 0.2) {
            self.setTitleColor(.gray, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 2.0) {
                self.setTitleColor(self.originalTextColor, for: .normal)
            }
        }
    }
}
