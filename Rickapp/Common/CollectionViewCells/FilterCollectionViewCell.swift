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

protocol FilterCollectionViewCellDelegate: AnyObject {
    func filterCell(_ cell: FilterCollectionViewCell, didChangeSelectionState selected: Bool)
}

class FilterCollectionViewCell: BaseCollectionViewCell {
    private let customTitleLabel = UILabel()
    private let selectionImageView = UIImageView()
    private let stackView = UIStackView()
    
    weak var delegate: FilterCollectionViewCellDelegate?
    
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
    
    var style: FilterViewStyle = .square {
        didSet {
            setupStyle()
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            customTitleLabel.textColor = titleColor
        }
    }
    
    var filter: String = ""
    
    override func setupViews() {
        super.setupViews()
        
        setupStyle()
        
        customTitleLabel.textAlignment = .center
        customTitleLabel.font = .systemFont(ofSize: 16)
        customTitleLabel.textColor = .white
        
        selectionImageView.image = UIImage.getImage(.plusIcon)
        selectionImageView.tintColor = .white
        selectionImageView.contentMode = .left
        
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
        selectionImageView.image = UIImage.getImage(cellSelected ? .checkmarkIcon : .plusIcon)
        backgroundColor = cellSelected ? (color ?? .white) : .clear
        customTitleLabel.textColor = cellSelected ? .gray : (color ?? titleColor ??  .white)
        
    }
    
    func setupTitle(_ title: String) {
        customTitleLabel.text = title
        filter = title
        delegate?.filterCell(self, didChangeSelectionState: cellSelected)
    }
}

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        color = nil
//        customTitleLabel.font = .systemFont(ofSize: 16)
//    }
