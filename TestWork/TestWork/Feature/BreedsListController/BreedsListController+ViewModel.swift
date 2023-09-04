//
//  BreedsListController+ViewModel.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation

class BreedsListControllerViewModel {
    private var networkManager: NetworkManager
    @Published
    private(set) var breedsArray: [BreedModel] = []
    var page: Int = 0
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getBreeds() {
        Task { @MainActor in
            do {
                let result = try await networkManager.getBreeds(page: page)
                self.breedsArray.append(contentsOf: result)
            } catch let error {
                print(error)
            }
        }
    }
}
