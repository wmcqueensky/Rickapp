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
    var dateFilters: [String] = []
        
    override func bindToData() {
        super.bindToData()
        getCharacters()
        getLocations()
    }
    
    func getCharacters() {
        CharacterService.shared.getCharacters()
            .sink(receiveCompletion: { _ in }) { [weak self] characters in
                self?.characterPublisher.send(characters.results ?? [])
            }
            .store(in: &cancellables)
    }
    
    func getLocations() {
        CharacterService.shared.getLocations()
            .sink(receiveCompletion: { _ in }) { [weak self] locationList in
                self?.locationsPublisher.send(locationList.results ?? [])
            }
            .store(in: &cancellables)
    }
    
    func getEpisodes() {
        CharacterService.shared.getEpisodes()
            .sink(receiveCompletion: { _ in }) { [weak self] episodesList in
                self?.episodesPublisher.send(episodesList.results ?? [])
            }
            .store(in: &cancellables)
    }
    
    @objc func navigateToSearchController() {
        
    }
}

extension SearchFiltersViewModel: FiltersCollectionViewDelegate {
    func cellSelected(filter: String) {
        
    }
}

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
