//
//  UnderlinedButton.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import SnapKit

class UnderlinedButton: BaseButton {
    
    var attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    var title = "" {
        didSet {
            let attributedString = NSMutableAttributedString(string: title, attributes: attributes)
            setAttributedTitle(attributedString, for: .normal)
        }
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        
        attributes = [.font: UIFont.boldSystemFont(ofSize: 16),
                      .foregroundColor: color!,
                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSMutableAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedString, for: .normal)
    }
}
