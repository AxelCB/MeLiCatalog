//
//  ServiceResponse.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 12/04/2021.
//

import Foundation

struct ServiceResponse {
    struct Paginated<T: Decodable>: Decodable {
        let paging: Page
        let results: [T]
    }
    
    struct Item<T: Decodable>: Decodable {
        let code: Int
        let body: T
    }
    
    struct Description: Codable {
        let text: String
        
        enum CodingKeys: String, CodingKey {
            case text = "plain_text"
        }
    }
}
