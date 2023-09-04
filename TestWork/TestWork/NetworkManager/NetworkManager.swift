//
//  NetworkManager.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation
import Moya

class NetworkManager {
    let provider = MoyaProvider<CatApiManager>(plugins: [NetworkLoggerPlugin()])
    
    func getBreeds(page: Int = 0) async throws -> [BreedModel] {
        return try await withCheckedThrowingContinuation({ continuation in
            provider.request(.breeds(page: page)) {[weak self] result in
                guard let self else { return }
                switch result {
                    case let .success(response):
                        do {
                            guard let _ = response.request else {
                                fatalError("guard failure handling has not been implemented")
                            }
                            let items = try JSONDecoder().decode([BreedModel].self, from: response.data)
                            continuation.resume(returning: items)
                        } catch let error {
                            continuation.resume(throwing: error)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        })
    }
}
