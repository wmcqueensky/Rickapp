//
//  CharacterListViewModel.swift
//  Rickapp
//
//  Created by Goodylabs on 22/08/2023.
//

import Foundation
import UIKit

class CharacterListViewModel: UIViewController {
    private let baseURL = "https://rickandmortyapi.com/api/character"
    
    internal var characters: [Character] = []
    
    func setupData() {
        guard let url = URL(string: baseURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    self.characters = response.results ?? []
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}
