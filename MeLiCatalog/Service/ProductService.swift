//
//  ProductService.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 08/04/2021.
//

import Foundation
import Combine


class ProductService {
    static let shared = ProductService()
    
    let networkClient: NetworkClient
    
    fileprivate init(networkClient: NetworkClient = URLSession.shared) {
        self.networkClient = networkClient
    }
    
    func getNextPageFrom(_ currentPage: Page, withSearchTerm searchTerm: String?) -> AnyPublisher<ServiceResponse.Paginated<Product>, Error> {
        let nextPage = Page(offset: currentPage.offset + currentPage.limit, limit: currentPage.limit)
        return loadPage(page: nextPage, withSearchTerm: searchTerm)
    }
    
    func loadPage(page: Page, withSearchTerm searchTerm: String?) -> AnyPublisher<ServiceResponse.Paginated<Product>, Error> {
        networkClient.performRequest(Endpoint.search(searchTerm, forPage: page))
            .decode(type: ServiceResponse.Paginated<Product>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadProduct(withId productId: String) -> AnyPublisher<ProductDetail, Error> {
        networkClient.performRequest(Endpoint.productDetail(withId: productId))
            .decode(type: [ServiceResponse.Item<ProductDetail>].self, decoder: JSONDecoder())
            .compactMap{ $0.first }
            .map(\.body)
            .zip(loadDescrption(withProductId: productId))
            .map { productDetail, description -> ProductDetail in
                var productDetail = productDetail
                productDetail.updateDescription(with: description)
                return productDetail
            }
            .eraseToAnyPublisher()
    }
    
    func loadDescrption(withProductId productId: String) -> AnyPublisher<String, Error> {
        networkClient.performRequest(Endpoint.description(withProductId: productId))
            .decode(type: ServiceResponse.Description.self, decoder: JSONDecoder())
            .map(\.text)
            .eraseToAnyPublisher()
    }
}
