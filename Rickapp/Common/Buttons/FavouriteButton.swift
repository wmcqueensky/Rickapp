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
        let heartImageView = UIImageView(image: UIImage.getImage(.heartIcon))
        heartImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        heartImageView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        heartImageView.isUserInteractionEnabled = false
        
        addSubview(heartImageView)

        UIView.animate(withDuration: 0.3, animations: {
            heartImageView.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
            heartImageView.alpha = 0
        }) { _ in
            heartImageView.removeFromSuperview()
        }
    }
}
