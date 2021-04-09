//
//  Page.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 09/04/2021.
//

import Foundation

struct Page: Codable {
    let total: Int
    let offset: Int
    var limit: Int = 15
}
