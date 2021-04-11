//
//  Page.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 09/04/2021.
//

import Foundation

struct Page: Codable {
    let total: Int?
    let offset: Int
    var limit: Int
    
    init(offset: Int, limit: Int = 15) {
        self.init(total: nil, offset: offset, limit: limit)
    }
    
    init(total: Int?, offset: Int, limit: Int) {
        self.total = total
        self.offset = offset
        self.limit = limit
    }
}
