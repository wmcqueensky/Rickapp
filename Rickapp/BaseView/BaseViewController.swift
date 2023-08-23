//
//  BaseViewModel.swift
//  Rickapp
//
//  Created by Goodylabs on 23/08/2023.
//


import UIKit
import SnapKit
import Combine

class BaseViewController<T: BaseViewModel>: UIViewController, UIScrollViewDelegate {
    var viewModel: T!
    var cancellables = Set<AnyCancellable>()
        
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

