//
//  AboutBreedController+ViewModel.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation
import Combine

final class AboutBreedControllerViewModel {
    // - Data
    @Published private(set) var wikiURL: String
    private(set) var breedName: String
    
    init(wikiURL: String, breedName: String) {
        self.wikiURL = wikiURL
        self.breedName = breedName
    }
}
