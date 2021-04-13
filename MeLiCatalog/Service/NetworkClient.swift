//
//  NetworkClient.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 12/04/2021.
//

import Foundation
import Combine

protocol NetworkClient {
    func performRequest(_ endpoint: Endpoint) -> AnyPublisher<Data, Error>
}

extension URLSession: NetworkClient {
    func performRequest(_ endpoint: Endpoint) -> AnyPublisher<Data, Error> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return dataTaskPublisher(for: URLRequest(url: url))
            .map(\.data)
            .mapError{ NetworkError.connectionError($0) }
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case invalidUrl
    case noConnection
    case connectionError(Error)
}
