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
    private let informationStackView = UIStackView()
    private let charactersStackView = UIStackView()
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
        
        viewModel.charactersPublisher
            .sink { [weak self] characters in
                self?.populateStackWithData(characters)
            }
            .store(in: &viewModel.cancellables)
    }
    
    override func setupViews() {
        super.setupViews()
        nameLabel.font = .boldSystemFont(ofSize: 44)
        nameLabel.numberOfLines = 0
        
        typeLabel.text = "Type:"
        dimensionLabel.text = "Dimension:"
        residentsLabel.text = "Residents:"
        
        view.setTextColorForLabels([typeLabel, dimensionLabel, residentsLabel], color: .gray)
        view.setTextColorForLabels([nameLabel, actualTypeLabel, actualDimensionLabel, actualResidentsLabel], color: .white)
        view.setFontForLabels([typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel, residentsLabel, actualResidentsLabel], font: .boldSystemFont(ofSize: 24))
        
        informationStackView.backgroundColor = .darkGray
        informationStackView.axis = .vertical
        informationStackView.spacing = 3
        informationStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        informationStackView.addArrangedSubviews([nameLabel, typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel, residentsLabel, actualResidentsLabel])
        
        charactersStackView.axis = .vertical
        
        view.backgroundColor = .darkGray
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(charactersStackView)
        view.addSubview(informationStackView)
        view.addSubview(scrollView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(scrollView.snp.top)
        }
        
        charactersStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(scrollView)
        }
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupData(_ location: Location) {
        nameLabel.text = location.name ?? ""
        actualTypeLabel.text = location.type ?? ""
        actualDimensionLabel.text = location.dimension ?? ""
    }
    
    private func populateStackWithData(_ characters: [Character]) {
        for character in characters {
            let characterButton = UIButton()
            
//            characterButton.setTitle(character.name, for: .normal)
//            characterButton.kf.setImage(with: URL(string: character.image ?? ""), for: .normal)
//            characterButton.imageView?.contentMode = .scaleAspectFill
//            characterButton.imageView?.layer.cornerRadius = characterButton.frame.height / 2
//            characterButton.imageView?.layer.masksToBounds = true
//            characterButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -characterButton.imageView!.frame.width, bottom: -characterButton.imageView!.frame.height, right: 0)
            characterButton.addTarget(self, action: #selector(characterButtonTapped(_:)), for: .touchUpInside)
            charactersStackView.addArrangedSubview(characterButton)
        }
    }
    
    @objc private func characterButtonTapped(_ sender: PlanetButton) {
        viewModel.getCharacterById(1)
    }
}
