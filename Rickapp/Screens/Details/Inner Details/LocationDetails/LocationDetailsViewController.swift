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
    private let tableView = UITableView()
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let actualTypeLabel = UILabel()
    private let dimensionLabel = UILabel()
    private let actualDimensionLabel = UILabel()
    private let residentsLabel = UILabel()
    private let actualResidentsLabel = UILabel()
    private let backgroundImageView = UIImageView(image: UIImage.getImage(.starsImage))
    
    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.locationPublisher
            .sink { [weak self] location in
                self?.setupData(location)
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.charactersPublisher
            .sink { [weak self] characters in
                self?.tableView.reloadData()
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
        
        backgroundImageView.contentMode = .scaleAspectFill
        
        //        informationStackView.addSubview(backgroundImageView)
        informationStackView.backgroundColor = .darkGray
        informationStackView.axis = .vertical
        informationStackView.spacing = 3
        informationStackView.setEdgeInsets(top: 7, left: 15, bottom: 16, right:15)
        informationStackView.addArrangedSubviews([nameLabel, typeLabel, actualTypeLabel, dimensionLabel, actualDimensionLabel, residentsLabel, actualResidentsLabel])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCircleViewCell.self, forCellReuseIdentifier: String(describing: CharacterCircleViewCell.self))
        tableView.backgroundColor = .darkGray
        tableView.showsVerticalScrollIndicator = false

        //        view.addSubview(backgroundImageView)
        //        view.sendSubviewToBack(backgroundImageView)
        
        view.backgroundColor = .darkGray
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
            make.top.equalTo(informationStackView.snp.bottom)
        }
    }
    
    private func setupData(_ location: Location) {
        nameLabel.text = location.name ?? ""
        actualTypeLabel.text = location.type ?? ""
        actualDimensionLabel.text = location.dimension ?? ""
    }
}

extension LocationDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characterId = viewModel.charactersPublisher.value[indexPath.row].id else { return }
        viewModel.getCharacterById(characterId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersPublisher.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterCircleViewCell.self)) as? CharacterCircleViewCell else { return UITableViewCell() }
        
        cell.character = viewModel.charactersPublisher.value[indexPath.row]
        
        switch indexPath.row % 4 {
        case 0:
            cell.alignment = .centre
        case 1:
            cell.alignment = .right
        case 2:
            cell.alignment = .centre
        default:
            cell.alignment = .left
        }
        
        return cell
    }
}
