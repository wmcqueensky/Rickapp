//
//  BaseTextField.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 25/09/2023.
//

import UIKit

class BaseTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
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
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
