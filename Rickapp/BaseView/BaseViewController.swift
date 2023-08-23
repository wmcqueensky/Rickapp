//
//  BaseViewModel.swift
//  Rickapp
//
//  Created by Goodylabs on 23/08/2023.
//


import UIKit
import SnapKit

class BaseViewController<T: BaseViewModel>: UIViewController, UIScrollViewDelegate {
    var viewModel: T!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        
        setupViews()
        setupConstraints()
        setupData()
        bindToViewModel()

    }
    
    func setupData() {}

    func setupViews() {}
    
    func bindToViewModel() {}
    
    func setupConstraints() {}
}

