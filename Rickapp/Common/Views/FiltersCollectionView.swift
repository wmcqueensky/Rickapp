//
//  FiltersCollectionView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import SnapKit

protocol FiltersCollectionViewDelegate: AnyObject {
    func cellSelected(filter: String)
}

class FiltersCollectionView: BaseView {
    private let collectionView = HeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    var elements: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var selectedElements: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var style = FilterViewStyle.round
    var titleColor: UIColor?
    
    weak var delegate: FiltersCollectionViewDelegate?
    
    override func setupViews() {
        super.setupViews()
        let layout = FiltersCollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10

        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .clear
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FilterCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func reload(_ elements: [Location]) {
        elements.forEach { element in
            self.elements.append(element.name ?? "")
        }
    }
}

extension FiltersCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = elements[indexPath.item]
        
        if selectedElements.contains(item) {
            selectedElements.remove(at: selectedElements.firstIndex(of: item) ?? -1)
        } else {
            selectedElements.append(item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FilterCollectionViewCell.self), for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell()}
        
        cell.setupTitle(elements[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = elements[indexPath.row]
        let label = UILabel()
        label.text = tag
        label.sizeToFit()
        
        let isSelected = selectedElements.contains(tag)
        return CGSize(width: label.frame.width + (isSelected ? 100 : 80), height: 46)
    }
}
