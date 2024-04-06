//
//  FiltersSectionView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import SnapKit

protocol FiltersSectionDelegate: AnyObject {
    func cellSelected(filter: String, section: String)
    func clearButtonTapped(_ filters: [String], section: String)
}

class FiltersSectionView: BaseView {
    private let clearButton = UnderlinedButton()
    private let titleButton = UIButton()
    private let dividerView = DividerView()
    private let collectionView = HeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let stackView = UIStackView()
    private let titleButtonStackView = UIStackView()
    private let titleStackView = UIStackView()
    
    let counterView = CounterView()
    
    var title = "" {
        didSet {
            titleStackView.isHidden = title.isEmpty
            dividerView.isHidden = title.isEmpty
            titleButton.setTitle(title, for: .normal)
        }
    }
    
    private var filters: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: FiltersSectionDelegate?
    
    override func setupViews() {
        super.setupViews()
        titleButton.titleLabel?.font = .boldSystemFont(ofSize: 25)
        titleButton.titleLabel?.textColor = .white
        titleButton.titleLabel?.numberOfLines = 0
        titleButton.addTarget(self, action: #selector(titleButtonTapped), for: .touchUpInside)
        
        dividerView.isHidden = true
        
        clearButton.title = "Clear"
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        titleButtonStackView.spacing = 5
        titleButtonStackView.addArrangedSubviews([titleButton, counterView])
        
        titleStackView.isHidden = true
        titleStackView.spacing = 20
        titleStackView.axis = .horizontal
        titleStackView.addArrangedSubviews([titleButtonStackView, UIView(), clearButton])
        
        let layout = FiltersCollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .clear
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FilterCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        
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
    
    func collectionViewLoad(_ elements: [Location]) {
        elements.forEach { element in
            self.filters.append(element.name ?? "")
        }
    }
    
    @objc private func titleButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.isHidden = !self.collectionView.isHidden
        }
    }
}

extension FiltersSectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FilterCollectionViewCell.self), for: indexPath) as? FilterCollectionViewCell else {return UICollectionViewCell()}
        
        cell.setupTitle(filters[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = filters[indexPath.row]
        let label = UILabel()
        label.text = tag
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 80, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell else { return }
        let item = filters[indexPath.item]
        delegate?.cellSelected(filter: item, section: self.title)
        cell.cellSelected = !cell.cellSelected
    }
    
    @objc private func clearButtonTapped() {
        for indexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
                cell.cellSelected = false
            }
        }
        delegate?.clearButtonTapped(filters, section: self.title)
    }
}
