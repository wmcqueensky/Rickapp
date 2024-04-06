//
//  SearchFiltersViewModel.swift
//  Rickapp
//
//  Created by Wojciech Mokwiński on 26/09/2023.
//

import UIKit
import Combine
import Moya

class SearchFiltersViewModel: BaseListViewModel {
    var searchText = ""
    let characterPublisher = CurrentValueSubject<[Character], Never>([])
    let locationsPublisher = CurrentValueSubject<[Location], Never>([])
    let episodesPublisher = CurrentValueSubject<[Episode], Never>([])
    
    var statusFilters: [String] = []
    var speciesFilters: [String] = []
    var typeFilters: [String] = []
    var genderFilters: [String] = []
    var locationFilters: [String] = []
    var originFilters: [String] = []
    var dateFilters: [String] = []
    
    var selectedStatusFilters: [String] = []
    var selectedSpeciesFilters: [String] = []
    var selectedTypeFilters: [String] = []
    var selectedGenderFilters: [String] = []
    var selectedLocationFilters: [String] = []
    var selectedOriginFilters: [String] = []
    
    override func bindToData() {
        super.bindToData()
        getLocations()
    }
    
    func getLocations() {
        CharacterService.shared.getLocations()
            .sink(receiveCompletion: { _ in }) { [weak self] locationList in
                self?.locationsPublisher.send(locationList.results ?? [])
            }
            .store(in: &cancellables)
    }
    
    func populateLocationFilters(_ locations: [Location]) {
        locations.forEach { location in
            self.locationFilters.append(location.name ?? "")
        }
    }
    
    func populateOriginFilters(_ origins: [Location]) {
        origins.forEach { origin in
            self.originFilters.append(origin.name ?? "")
        }
    }
    
    @objc func navigateToSearchController() {
        
    }
}

extension SearchFiltersViewModel: FiltersSectionDelegate {
    
    func clearButtonTapped(_ filters: [String], section: String) {
        if section == "Location" && !filters.isEmpty {
            selectedLocationFilters.removeAll()
        }
        
        if section == "Origin" && !filters.isEmpty {
            selectedOriginFilters.removeAll()
        }
    }
    
    func cellSelected(filter: String, section: String) {
        if section == "Location" {
            if selectedLocationFilters.contains(filter) {
                selectedLocationFilters.remove(at: selectedLocationFilters.firstIndex(of: filter) ?? -1)
            } else {
                selectedLocationFilters.append(filter)
            }
        }
        
        if section == "Origin" {
            if selectedOriginFilters.contains(filter) {
                selectedOriginFilters.remove(at: selectedOriginFilters.firstIndex(of: filter) ?? -1)
            } else {
                selectedOriginFilters.append(filter)
            }
        }
    }
    
    func counterValueChanged(numberOfFilters: Int, section: String) {
        if section == "Location" {
           
        }
        
        if section == "Origin" {
            
        }
    }
}

//    func didTapFavouriteButton(for cell: CharacterTableViewCell, isSelected: Bool) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        let character = viewModel.charactersPublisher.value[indexPath.row]
//        viewModel.toggleFavoriteStatus(for: character, isSelected: isSelected)
//    }

//extension SearchFiltersViewModel: FilterSectionDelegate {
//    func clearButtonTapped(_ tags: [Tag]) {
//        var tagsTemp: [Tag] = []
//
//        tagsTemp = tags
//        if tagsTemp.contains(lengthTags.first ?? Tag()) {
//            tagsTemp.append(contentsOf: dateTags)
//        }
//
//        var selectedTags = selectedTags.value
//        selectedTags = selectedTags.filter { !tagsTemp.contains($0) }
//        self.selectedTags.send(selectedTags)
//    }
//}

//extension SearchFiltersViewModel: SearchDelegate {
//    func unwindSearch(tags: [Tag], searchText: String) {
//        self.selectedTags.send(tags)
//        self.searchText = searchText
//    }
//}

//extension SearchFiltersViewModel: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        navigateToSearchController()
//        return true
//    }
//}


//
//    func getCharacters() {
//        CharacterService.shared.getCharacters()
//            .sink(receiveCompletion: { _ in }) { [weak self] characters in
//                self?.characterPublisher.send(characters.results ?? [])
//            }
//            .store(in: &cancellables)
//    }
//
//
//    func getEpisodes() {
//        CharacterService.shared.getEpisodes()
//            .sink(receiveCompletion: { _ in }) { [weak self] episodesList in
//                self?.episodesPublisher.send(episodesList.results ?? [])
//            }
//            .store(in: &cancellables)
//    }

