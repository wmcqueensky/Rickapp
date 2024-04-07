//
//  LocationInfoView.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 19/09/2023.
//

import UIKit
import SnapKit

class LocationInfoView: BaseView {
    private let informationStackView = UIStackView()
    private let tableView = UITableView()
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let dimensionLabel = UILabel()
    private let actualDimensionLabel = UILabel()
    
    var location: Location? {
        didSet {
            setupLocation()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        typeLabel.text = "Type of location:"
        dimensionLabel.text = "Dimension:"
        
        setTextColorForLabels([typeLabel, dimensionLabel], color: .gray)
        setTextColorForLabels([actualTypeLabel, actualDimensionLabel], color: .white)
        setFontForLabels([typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel], font: .systemFont(ofSize: 20))
        
        informationStackView.axis = .vertical
        informationStackView.spacing = 3
        informationStackView.setEdgeInsets(top: 0, left: 0, bottom: 20, right:0)
        informationStackView.addArrangedSubviews([typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel])
        informationStackView.setCustomSpacing(20, after: actualTypeLabel)
        
        backgroundColor = .darkGray
        addSubview(informationStackView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        informationStackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func setupLocation() {
        guard let location = location else { return }
        actualTypeLabel.text = location.type ?? ""
        actualDimensionLabel.text = location.dimension ?? ""
    }
    
    func toggle() {
        UIView.animate(withDuration: 0.3) {
            self.isHidden.toggle()
        }
    }
}
