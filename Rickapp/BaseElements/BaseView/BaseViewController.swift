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
    
    var hideBarWhenScrolling = false
    
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
    
    func configurePushNavigationBar() {
        guard let appearance = navigationController?.navigationBar.standardAppearance else { return }
        
        let app = UIBarButtonItemAppearance(style: .plain)
        app.normal.backgroundImage = UIImage.getImage(.backButton)
        appearance.backButtonAppearance = app
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
