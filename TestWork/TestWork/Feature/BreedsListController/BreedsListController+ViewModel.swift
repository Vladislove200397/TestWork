//
//  BreedsListController+ViewModel.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation

final class BreedsListControllerViewModel {
    // - Property
    var breedsDataService: NetworkManager<[BreedModel]>
    private var loadTask: Task<Void, Never>?
    
    // - Data
    @Published private(set) var breedsArray: [BreedModel] = []
    
    // - Flag
    var page: Int = 0
    var isLoad = false
    
    // - Lifecycle
    init(
        breedNetworkManager: NetworkManager<[BreedModel]>
    ) {
        self.breedsDataService = breedNetworkManager
    }
    
//MARK: Get Data
    func getBreeds() {
        isLoad = true
        loadTask?.cancel()
        
        loadTask = Task {
            do {
                let breedsModel = try await breedsDataService.getData(.breeds(page: page))
                breedsArray.append(contentsOf: breedsModel)
                isLoad = false
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
