//
//  Product.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 07/04/2021.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String
    let price: Double
    let stock: Int
    let imageUrl: String
    
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
        case imageUrl = "thumbnail"
    }
}

extension Product: Identifiable {}
extension Product: Hashable {}

extension Product {
    static let EXAMPLE = Product(id: "MLA101010101", title: "Samsung Galaxy A51 128 Gb Prism Crush White 4 Gb Ram", price: 42999, stock: 10, imageUrl: "http://http2.mlstatic.com/D_780046-MLA44443560272_122020-I.jpg")
}
