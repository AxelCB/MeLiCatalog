//
//  ProductService.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 08/04/2021.
//

import Foundation
import Combine
import Network

class ProductService {
    static let shared = ProductService()
    
    let networkClient: NetworkClient
    let monitor: NWPathMonitor
    var isDeviceCurrentlyConnected = false
    
    fileprivate init(networkClient: NetworkClient = URLSession.shared) {
        self.networkClient = networkClient
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            self.isDeviceCurrentlyConnected = path.status == .satisfied
            print(path)
        }
        monitor.start(queue: .global())
    }
    
    func getNextPageFrom(_ currentPage: Page, withSearchTerm searchTerm: String?) -> AnyPublisher<ServiceResponse.Paginated<Product>, Error> {
        let nextPage = Page(offset: currentPage.offset + currentPage.limit, limit: currentPage.limit)
        return loadPage(page: nextPage, withSearchTerm: searchTerm)
    }
    
    func loadPage(page: Page, withSearchTerm searchTerm: String?) -> AnyPublisher<ServiceResponse.Paginated<Product>, Error> {
        guard isDeviceCurrentlyConnected else {
            return Fail(error: NetworkError.noConnection).eraseToAnyPublisher()
        }
        return networkClient.performRequest(Endpoint.search(searchTerm, forPage: page))
            .decode(type: ServiceResponse.Paginated<Product>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadProduct(withId productId: String) -> AnyPublisher<ProductDetail, Error> {
        guard isDeviceCurrentlyConnected else {
            return Fail(error: NetworkError.noConnection).eraseToAnyPublisher()
        }
        return networkClient.performRequest(Endpoint.productDetail(withId: productId))
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
        guard isDeviceCurrentlyConnected else {
            return Fail(error: NetworkError.noConnection).eraseToAnyPublisher()
        }
        return networkClient.performRequest(Endpoint.description(withProductId: productId))
            .decode(type: ServiceResponse.Description.self, decoder: JSONDecoder())
            .map(\.text)
            .eraseToAnyPublisher()
    }
}
