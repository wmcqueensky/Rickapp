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
    
    var hideBarWhenScrolling = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGray
        
        setupViews()
        setupConstraints()
        setupData()
    }
    
    func setupData() {}

    func setupViews() {}
    
    func setupConstraints() {}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !hideBarWhenScrolling { return }
        if scrollView.contentOffset.y > 0 {
           navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
           navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
}

