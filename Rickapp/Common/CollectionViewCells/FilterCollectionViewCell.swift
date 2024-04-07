//
//  FilterCollectionViewCell.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 27/09/2023.
//

import UIKit
import SnapKit

enum FilterViewStyle {
    case round
    case square
}

class FilterCollectionViewCell: BaseCollectionViewCell {
    private let customTitleLabel = UILabel()
    private let selectionImageView = UIImageView()
    private let stackView = UIStackView()
    
    var tagElement = String() {
        didSet {
            customTitleLabel.text = tagElement
        }
    }
    
    var cellSelected = false {
        didSet {
            setupSelection()
        }
    }

    var color: UIColor? {
        didSet {
            setupColor()
        }
    }
    
    var style: FilterViewStyle = .round {
        didSet {
            setupStyle()
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            customTitleLabel.textColor = titleColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        color = nil
        customTitleLabel.font = .systemFont(ofSize: 16)
    }
    
    override func setupViews() {
        super.setupViews()
        
        customTitleLabel.textAlignment = .center
        customTitleLabel.font = .systemFont(ofSize: 16)
        customTitleLabel.textColor = .green
        
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.addArrangedSubviews([selectionImageView, customTitleLabel])

        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
        addSubview(stackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self)
            make.horizontalEdges.equalTo(self).inset(20)
        }
    }
    
    private func setupStyle() {
        layer.cornerRadius = style == .round ? 25 : 7
    }
    
    private func setupColor() {
        guard let color = color else { return }
        customTitleLabel.font = .systemFont(ofSize: 16)
        customTitleLabel.textColor = color
        layer.borderColor = color.cgColor
    }
    
    private func setupSelection() {
        layer.borderWidth = cellSelected ? 0 : 1
        selectionImageView.isHidden = !cellSelected
        backgroundColor = cellSelected ? (color ?? .white) : .clear
        customTitleLabel.textColor = cellSelected ? .gray : (color ?? titleColor ??  .white)
    }
}
