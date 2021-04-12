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
    
    let urlSession = URLSession.shared
    
    private let baseUrl = URL(string: "https://api.mercadolibre.com")!
    
    fileprivate init() {}
    
    func getNextPageFrom(_ currentPage: Page, withSearchTerm searchTerm: String?) -> AnyPublisher<PaginatedResponse<Product>, Error> {
        let nextPage = Page(offset: currentPage.offset + currentPage.limit, limit: currentPage.limit)
        return loadPage(page: nextPage, withSearchTerm: searchTerm)
    }
    
    func loadPage(page: Page, withSearchTerm searchTerm: String?) -> AnyPublisher<PaginatedResponse<Product>, Error> {
        urlSession.dataTaskPublisher(for: resolveURL(forPage: page, andSearchTerm: searchTerm))
            .map(\.data)
            .decode(type: PaginatedResponse<Product>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func resolveURL(forPage page: Page, andSearchTerm searchTerm: String?) -> URLRequest {
        let url = baseUrl.appendingPathComponent("/sites/MLA/search")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "q", value: searchTerm),
            URLQueryItem(name: "offset", value: String(page.offset)),
            URLQueryItem(name: "limit", value: String(page.limit))
        ]
        return URLRequest(url: components.url!)
    }
    
    func loadProduct(withId productId: String) -> AnyPublisher<ProductDetail, Error> {
        urlSession.dataTaskPublisher(for: resolveURL(forProductId: productId))
            .map(\.data)
            .decode(type: [ItemResponse<ProductDetail>].self, decoder: JSONDecoder())
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
        urlSession.dataTaskPublisher(for: URLRequest(url: baseUrl.appendingPathComponent("/items/\(productId)/description")))
            .map(\.data)
            .decode(type: DescriptionResponse.self, decoder: JSONDecoder())
            .map(\.text)
            .eraseToAnyPublisher()
    }
    
    private func resolveURL(forProductId productId: String) -> URLRequest {
        let url = baseUrl.appendingPathComponent("/items")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "ids", value: productId)
        ]
        return URLRequest(url: components.url!)
    }
}
