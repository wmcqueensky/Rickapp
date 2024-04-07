//
//  BaseViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 23/08/2023.
//


import UIKit
import SnapKit
import Combine

class BaseViewController<T: BaseViewModel>: UIViewController {
    var viewModel: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        
        setupViews()
        setupConstraints()
        bindToViewModel()
        viewModel.bindToData()
        setupData()
    }
    
    func setupData() {}

    func setupViews() {}
    
    func bindToViewModel() {}
    
    func setupConstraints() {}
}

