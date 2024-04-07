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
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let dimensionLabel = UILabel()
    private let actualDimensionLabel = UILabel()
    private let residentsLabel = UILabel()
    private let actualResidentsLabel = UILabel()
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
        nameLabel.font = .boldSystemFont(ofSize: 50)
        nameLabel.numberOfLines = 0
        
        typeLabel.text = "Type:"
        dimensionLabel.text = "Dimension:"
        residentsLabel.text = "Residents:"
        
        view.setTextColorForLabels([typeLabel, dimensionLabel, residentsLabel], color: .gray)
        view.setTextColorForLabels([nameLabel, actualTypeLabel, actualDimensionLabel, actualResidentsLabel], color: .white)
        view.setFontForLabels([typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel, residentsLabel, actualResidentsLabel], font: .systemFont(ofSize: 30))
        
        locationStackView.backgroundColor = .darkGray
        locationStackView.axis = .vertical
        locationStackView.spacing = 3
        locationStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        locationStackView.addArrangedSubviews([nameLabel, typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel, residentsLabel, actualResidentsLabel])
        
        view.backgroundColor = .darkGray
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(locationStackView)
        view.addSubview(scrollView)
    }
    
    override func setupConstraints() {
        locationStackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.horizontalEdges.equalTo(view)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupData(_ location: Location) {
        nameLabel.text = location.name ?? ""
        actualTypeLabel.text = location.type ?? ""
        actualDimensionLabel.text = location.dimension ?? ""
        let residentsNumbers = location.residents?.map { $0.components(separatedBy: "/").last ?? "" } ?? []
        let residentsText = residentsNumbers.isEmpty ? "N/A" : residentsNumbers.joined(separator: ", ")
        
        let formattedResidents = residentsNumbers.map { "Resident: \($0)" }
        let formattedResidentText = formattedResidents.joined(separator: "\n")
        
        actualResidentsLabel.text = formattedResidentText
    }
}
