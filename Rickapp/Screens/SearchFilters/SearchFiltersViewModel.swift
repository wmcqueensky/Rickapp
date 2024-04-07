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
    
    var statusFilters: [String] = ["Alive", "Dead", "unknown"]
    var Tags: [String] = []
    var lengthTags: [String] = []
    var dateTags: [String] = []
    
    let selectedTags = CurrentValueSubject<[String], Never>([])
    
    override func bindToData() {
        super.bindToData()
        
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
