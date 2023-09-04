//
//  APIManager.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation

enum BreedApiManager: RESTConstructor {
    case breeds(page: Int)
    case imageURL(id: String)
    
    var baseURL: String {
        switch self {
            case .breeds, .imageURL:
                return "https://api.thecatapi.com/v1/"
        }
    }
    
    var path: String {
        switch self {
            case .breeds:
                return "breeds"
            case .imageURL:
                return "images/search"
        }
    }
    
    var params: [String : Any]? {
        var parameters = [String: Any]()
        switch self {
            case .breeds(page: let page):
                parameters["limit"] = "10"
                parameters["page"] = "\(page)"
            case .imageURL(id: let id):
                parameters["breed_ids"] = id
        }
        return parameters
    }
    
    var method: RequestPathType {
        .query
    }
    
    var requestType: RequestType {
        .get
    }
    
    static func createURL(request: BreedApiManager) -> URLComponents {
        var components = URLComponents(string: "\(request.baseURL)\(request.path)\(request.method.requestPathType)")!
        
        guard let  parameters = request.params else {
            return components
        }

        components.queryItems = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: value as? String)
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        return components
    }

}
