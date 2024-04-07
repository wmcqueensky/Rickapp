//
//  FiltersSectionView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit

class FiltersSectionView: BaseView {
    private let clearButton = UnderlinedButton()
    private let titleLabel = UILabel()
    private let dividerView = DividerView()
    private let collectionView = FiltersCollectionView()
    private let stackView = UIStackView()
    private let titleStackView = UIStackView()
    
    var title = "" {
        didSet {
            titleStackView.isHidden = title.isEmpty
            dividerView.isHidden = title.isEmpty
            titleLabel.text = title
        }
    }

    override func setupViews() {
        super.setupViews()
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        dividerView.isHidden = true
        
        clearButton.title = "Clear"
//        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        titleStackView.isHidden = true
        titleStackView.spacing = 20
        titleStackView.axis = .horizontal
        titleStackView.addArrangedSubviews([titleLabel, UIView(), clearButton])
        
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.addArrangedSubviews([dividerView, titleStackView, collectionView])
        stackView.setCustomSpacing(20, after: titleStackView)
        
        addSubview(stackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
