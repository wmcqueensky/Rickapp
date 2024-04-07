//
//  SearchFiltersViewController.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import Moya
import SnapKit

class SearchFiltersViewController: BaseViewController<SearchFiltersViewModel> {
    private let searchView = SearchView()
    private let statusSectionView = FiltersSectionView()
    private let speciesSectionView = FiltersSectionView()
    private let typeSectionView = FiltersSectionView()
    private let genderSectionView = FiltersSectionView()
    private let locationSectionView = FiltersSectionView()
    private let originSectionView = FiltersSectionView()
    private let dateSectionView = FiltersSectionView()
//    private let moreButton = Button()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
//    private let applyButton = Button()
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        
    }
    
    override func setupViews() {
        super.setupViews()

        statusSectionView.title = "Status"
        speciesSectionView.title = "Species"
        typeSectionView.title = "Type"
        genderSectionView.title = "Gender"
        locationSectionView.title = "Location"
        originSectionView.title = "Origin"
        dateSectionView.title = "Date created"
                
//        applyButton.title = "Apply filters"
//        applyButton.style = .main
//        applyButton.color = .green
//        applyButton.addTarget(viewModel, action: #selector(viewModel.navigateToSearchController), for: .touchUpInside)

//        moreButton.style = .secondary
//        moreButton.color = .gray
//        moreButton.setTitleColor(.green, for: .normal)
//        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
//        moreButton.title = "View more"
        
//        searchView.delegate = viewModel
//        searchView.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.addArrangedSubviews([statusSectionView, speciesSectionView, typeSectionView, genderSectionView, locationSectionView, originSectionView, dateSectionView])
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.addSubview(searchView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        searchView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(scrollView.snp.top)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
