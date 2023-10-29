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
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.locationsPublisher
            .sink { [weak self] locations in
                self?.locationSectionView.collectionViewLoad(locations)
                self?.originSectionView.collectionViewLoad(locations)
                self?.viewModel.populateLocationFilters(locations)
                self?.viewModel.populateOriginFilters(locations)
            }
            .store(in: &viewModel.cancellables)
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
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.addArrangedSubviews([statusSectionView, speciesSectionView, typeSectionView, genderSectionView, locationSectionView, originSectionView, dateSectionView])
        
        [statusSectionView, speciesSectionView, typeSectionView, genderSectionView, locationSectionView, originSectionView, dateSectionView].forEach { view in
            view.delegate = viewModel
        }
        
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

//
//        viewModel.episodesPublisher
//            .sink { [weak self] locations in
//                self?.locationSectionView.collectionViewReload()
//                print(locations)
//            }
//            .store(in: &viewModel.cancellables)

//        viewModel.characterPublisher
//            .sink { [weak self] characters in
//
//            }
//            .store(in: &viewModel.cancellables)
//       
