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
        var tags: [String] = []
        elements.forEach { element in
            tags.append(element.name ?? "")
        }
        collectionView.reloadData()
    }
}

extension FiltersCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FilterCollectionViewCell.self), for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
}
