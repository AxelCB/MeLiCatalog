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
    let pictures: [Picture]
    var description: String?
    
    var formattedPrice: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.init(identifier: "es_AR")
        currencyFormatter.maximumFractionDigits = 0
        return currencyFormatter.string(from: NSNumber(value: price)) ?? "$0"
    }
    
    mutating func updateDescription(with text: String) {
        description = text
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
        case new = "new"
        case used = "used"
    }
    
    struct Picture: Codable {
        let id: String
        let url: String
    }
}

extension ProductDetail: Identifiable {}

extension ProductDetail {
    static let EXAMPLE = ProductDetail(id: "", title: "Samsung Galaxy A51 128 Gb Prism Crush White 4 Gb Ram", price: 42999, stock: 10, condition: .new, pictures: [Picture(id:"879201-MLA44443256851_122020",url:"http://http2.mlstatic.com/D_879201-MLA44443256851_122020-O.jpg"),
         Picture(id:"722810-MLA44443560665_122020",url:"http://http2.mlstatic.com/D_722810-MLA44443560665_122020-O.jpg"),
         Picture(id:"661720-MLA44443560664_122020",url:"http://http2.mlstatic.com/D_661720-MLA44443560664_122020-O.jpg"),
         Picture(id:"669618-MLA44444104023_122020",url:"http://http2.mlstatic.com/D_669618-MLA44444104023_122020-O.jpg"),
         Picture(id:"805850-MLA43336333258_092020",url:"http://http2.mlstatic.com/D_805850-MLA43336333258_092020-O.jpg")])
}
