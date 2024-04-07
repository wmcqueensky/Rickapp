//
//  SearchViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 22/09/2023.
//

import UIKit
import Moya
import SnapKit

class SearchViewController: BaseViewController<SearchViewModel> {
    private let resultsView = UICollectionView()
    private let searchView = SearchView()
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
    }
    
    override func setupViews() {
        super.setupViews()
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
}
