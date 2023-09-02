//
//  LocationDetailsViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 02/09/2023.
//

import UIKit
import Combine
import SnapKit

class LocationDetailsViewController: BaseViewController<LocationDetailsViewModel> {
    private let locationStackView = UIStackView()
    private let nameLabel = UILabel()
    private let scrollView = UIScrollView()
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.locationPublisher
            .sink { [weak self] location in
                self?.setupData(location)
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 0
        
        locationStackView.backgroundColor = .darkGray
        locationStackView.axis = .vertical
        locationStackView.spacing = 3
        locationStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        
        view.backgroundColor = .darkGray
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(locationStackView)
        view.addSubview(scrollView)
    }
    
    override func setupConstraints() {
        locationStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupData(_ location: Location) {
        nameLabel.text = location.name ?? ""
    }
}
