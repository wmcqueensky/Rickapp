//
//  FiltersSectionView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import SnapKit

protocol FiltersSectionDelegate: AnyObject {
    func clearButtonTapped(_ filters: [String])
    func cellSelected(filter: String, isSelected: Bool)
}

class FiltersSectionView: BaseView {
    private let clearButton = UnderlinedButton()
    private let titleLabel = UILabel()
    private let dividerView = DividerView()
    private let collectionView = HeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let stackView = UIStackView()
    private let titleStackView = UIStackView()
    
    var title = "" {
        didSet {
            titleStackView.isHidden = title.isEmpty
            dividerView.isHidden = title.isEmpty
            titleLabel.text = title
        }
    }
    
    var filters: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var selectedFilters: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: FiltersSectionDelegate?
    
    override func setupViews() {
        super.setupViews()
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        dividerView.isHidden = true
        
        clearButton.title = "Clear"
        
        titleStackView.isHidden = true
        titleStackView.spacing = 20
        titleStackView.axis = .horizontal
        titleStackView.addArrangedSubviews([titleLabel, UIView(), clearButton])
        
        let layout = FiltersCollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .clear
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FilterCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
}

extension FiltersSectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FilterCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FilterCollectionViewCell.self), for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell()}
        
        cell.setupTitle(filters[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = filters[indexPath.row]
        let label = UILabel()
        label.text = tag
        label.sizeToFit()
        
        let isSelected = selectedFilters.contains(tag)
        return CGSize(width: label.frame.width + (isSelected ? 100 : 80), height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = filters[indexPath.item]
        
        if selectedFilters.contains(item) {
            selectedFilters.remove(at: selectedFilters.firstIndex(of: item) ?? -1)
        } else {
            selectedFilters.append(item)
        }
        
        collectionView.reloadData() // Reload the collection view to update the cellSelected property.
        
        // Find the selected cell and update its cellSelected property.
        for cell in collectionView.visibleCells {
            if let filterCell = cell as? FilterCollectionViewCell, filterCell.filter == item {
                filterCell.cellSelected = selectedFilters.contains(item)
                break
            }
        }
    }
    
    func filterCell(_ cell: FilterCollectionViewCell, didChangeSelectionState selected: Bool) {
        let filter = cell.filter
        if selected {
            selectedFilters.append(filter)
        } else {
            if let index = selectedFilters.firstIndex(of: filter) {
                selectedFilters.remove(at: index)
            }
        }
    }
}

//        delegate?.cellSelected(filter: filters[indexPath.item], isSelected: true)


