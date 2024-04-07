//
//  SearchView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 25/09/2023.
//

import UIKit
import SnapKit

class SearchView: BaseTextField {
    private let searchImageView = UIImageView()
    
    var elementsAlpha: CGFloat = 0 {
        didSet {
            attributedPlaceholder = NSAttributedString(string: "Search", attributes: [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.white.withAlphaComponent(elementsAlpha)])
            searchImageView.alpha = elementsAlpha
        }
    }
    
    override func setupViews() {
        super.setupViews()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
}
