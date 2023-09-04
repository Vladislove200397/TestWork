//
//  APIManager.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation
import Moya

enum CatApiManager: TargetType {
case breeds(page: Int)
case image(id: String)
    
    var baseURL: URL {
        switch self {
            case .breeds:
                return URL(string: "https://api.thecatapi.com/v1")!
            case .image:
                return URL(string: "https://cdn2.thecatapi.com/images/")!
        }
    }
    
    var path: String {
        switch self {
            case .breeds:
                return "breeds"
            case .image(let id):
                return "\(id).jpg"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.queryString
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        switch self {
            case .breeds(page: let page):
                parameters["limit"] = "10"
                parameters["page"] = page
            default: return nil
        }
        return parameters
    }
    
    var headers: [String : String]? {
        nil
    }
}
