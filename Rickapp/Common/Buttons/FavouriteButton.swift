//
//  FavouriteButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 30/08/2023.
//

import UIKit

class FavouriteButton: BaseButton {
    override var isSelected: Bool {
        didSet {
            setImage(UIImage.getImage(.heartIcon), for: .normal)
            tintColor = isSelected ? UIColor.red : UIColor.white
        }
    }
    
    func animateHeartImage() {
        let targetScale: CGFloat = isSelected ? 1.2 : 1.0
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            self.transform = CGAffineTransform(scaleX: targetScale, y: targetScale)
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                if !self.isSelected {
                    self.transform = CGAffineTransform(translationX: 0, y: -20)
                    self.alpha = 0.0
                }
            }, completion: { _ in
                self.transform = .identity
                self.alpha = 1.0})
        }
    }
}
