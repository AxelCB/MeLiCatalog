//
//  ProductServiceTests.swift
//  MeLiCatalogTests
//
//  Created by Axel Collard Bovy on 12/04/2021.
//

import XCTest
import Combine
@testable import MeLiCatalog

class ProductServiceTests: XCTestCase {
    func testParsingFirstProduct() throws {
        let productService = ProductService(networkClient: MockedNetworkClient())
        let page = Page(offset: 0)
        let paginatedResponse: ServiceResponse.Paginated<Product> = try await(productService.getNextPageFrom(page, withSearchTerm: "samsung"))
        XCTAssertEqual(paginatedResponse.paging.limit, 50)
        XCTAssertEqual(paginatedResponse.results.count, 50)
        let firstProduct = paginatedResponse.results.first!
        XCTAssertEqual(firstProduct.id, "MLA883014060")
        XCTAssertEqual(firstProduct.title, "Samsung Galaxy A31 128 Gb Prism Crush Black 4 Gb Ram")
        XCTAssertEqual(firstProduct.imageUrl, "http://http2.mlstatic.com/D_629073-MLA45229549853_032021-I.jpg")
        XCTAssertEqual(firstProduct.price, 37801.0)
        XCTAssertEqual(firstProduct.stock, 108)
    }
}
