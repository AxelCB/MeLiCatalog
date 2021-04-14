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
    func testExample() throws {
        let productService = ProductService(networkClient: MockedNetworkClient())
        let page = Page(offset: 0)
        let paginatedResponse: ServiceResponse.Paginated<Product> = try await(productService.getNextPageFrom(page, withSearchTerm: "searchSomething"))
    }
}
