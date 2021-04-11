//
//  Product.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 07/04/2021.
//

import Foundation

struct ProductDetail: Codable {
    let id: String
    let title: String
    let price: Double
    let stock: Int
    let condition: Condition
    let pictures: [Picture] = []
    
    var formattedPrice: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.init(identifier: "es_AR")
        currencyFormatter.maximumFractionDigits = 0
        return currencyFormatter.string(from: NSNumber(value: price)) ?? "$0"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case stock = "available_quantity"
        case condition
        case pictures
    }
    
    enum Condition: String, Codable {
        case new
        case used
    }
    
    struct Picture: Codable {
        let id: String
        let url: String
    }
}

extension ProductDetail: Identifiable {}

extension ProductDetail {
    static let EXAMPLE = ProductDetail(id: "MLA101010101", title: "Samsung Galaxy A51 128 Gb Prism Crush White 4 Gb Ram", price: 42999, stock: 10, condition: .new)
}
