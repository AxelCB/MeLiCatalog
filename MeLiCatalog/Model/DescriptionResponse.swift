//
//  DescriptionResponse.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 11/04/2021.
//

import Foundation

struct DescriptionResponse: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "plain_text"
    }
}
