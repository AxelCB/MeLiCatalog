//
//  Endpoint.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 12/04/2021.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        guard let baseUrl = URL(string: "https://api.mercadolibre.com"), var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            return nil
        }
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

extension Endpoint {
    static func search(_ searchTerm: String?, forPage page: Page) -> Endpoint {
        return Endpoint(
            path: "/sites/MLA/search",
            queryItems: [
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "offset", value: String(page.offset)),
                URLQueryItem(name: "limit", value: String(page.limit))
            ]
        )
    }
    
    static func productDetail(withId productId: String) -> Endpoint {
        return Endpoint(path: "/items", queryItems: [
            URLQueryItem(name: "ids", value: productId),
        ])
    }
    
    static func description(withProductId productId: String) -> Endpoint {
        return Endpoint(path: "/items/\(productId)/description", queryItems: [])
    }
}
