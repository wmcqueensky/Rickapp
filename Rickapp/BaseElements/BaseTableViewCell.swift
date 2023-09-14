//
//  BaseTableViewCell.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 13/09/2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {}
    
    func setupConstraints() {}
}
