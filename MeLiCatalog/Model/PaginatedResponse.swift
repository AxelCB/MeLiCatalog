//
//  PaginatedResponse.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 09/04/2021.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let paging: Page
    let results: [T]
}
