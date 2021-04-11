//
//  ItemResponse.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 10/04/2021.
//

import Foundation

struct ItemResponse<T: Decodable>: Decodable {
    let code: Int
    let body: T   
}
