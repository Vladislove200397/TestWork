//
//  BreedModel.swift
//  TestWork
//
//  Created by Vlad Kulakovsky  on 4.09.23.
//

import Foundation

struct BreedModel: Decodable {
    var id: String
    var name: String
    var wikiURL: String?
    var imageID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case wikiURL = "wikipedia_url"
        case imageID = "reference_image_id"
    }
}
