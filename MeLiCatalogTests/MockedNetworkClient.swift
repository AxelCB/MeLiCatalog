//
//  MockedNetworkClient.swift
//  MeLiCatalogTests
//
//  Created by Axel Collard Bovy on 13/04/2021.
//

import XCTest
import Combine
@testable import MeLiCatalog

class MockedNetworkClient: NetworkClient {
    let jsonEncoder = JSONEncoder()
    
    func performRequest(_ endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        if endpoint.path == Endpoint.search("", forPage: Page(offset: 15)).path {
            let mockedDataDict: Dictionary<String, ServiceResponse.Paginated<Product>> = loadMockedData(.search)
            let searchTerm = endpoint.queryItems.first { $0.name == "q" }.flatMap { $0.value } ?? ""
            if let searchData = try? jsonEncoder.encode(mockedDataDict[searchTerm]) {
                return Just(searchData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
            }
        } else if endpoint.path == Endpoint.productDetail(withId: "").path {
            let mockedDataDict: Dictionary<String, ServiceResponse.Item<ProductDetail>> = loadMockedData(.productDetail)
            let productId = endpoint.queryItems.first { $0.name == "ids" }.flatMap { $0.value } ?? ""
            if let productDetailData = try? jsonEncoder.encode(mockedDataDict[productId]) {
                return Just(productDetailData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
            }
        } else if endpoint.path.contains("description") {
            let mockedDataDict: Dictionary<String, ServiceResponse.Description> = loadMockedData(.productDetail)
            let productId = String(endpoint.path.split(separator: "/")[1])
            if let descriptionData = try? jsonEncoder.encode(mockedDataDict[productId]) {
                return Just(descriptionData)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
            }
        } else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
    }
    
    func loadMockedData<T>(_ mockedDataType: MockedData) -> Dictionary<String, T> where T: Decodable {
        let jsonDecoder = JSONDecoder()
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: mockedDataType.fileName, ofType: "json") else {
            fatalError("Couldn't load mocked data \(mockedDataType.fileName)")
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8)  else {
            fatalError("Unable to convert mocked data as json")
        }
        
        return try! jsonDecoder.decode(Dictionary<String, T>.self, from: jsonData)
    }
}

enum MockedData {
    case search
    case productDetail
    case description
    
    var fileName: String {
        switch self {
        case .search:
            return "SearchMockedData"
        case .productDetail:
            return "ItemsMockedData"
        case .description:
            return "DescriptionsMockedData"
        }
    }
}
