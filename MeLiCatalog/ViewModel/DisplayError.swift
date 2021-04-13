//
//  DisplayError.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 13/04/2021.
//

import Foundation

struct DisplayError {
    let messageKey: String
    let cause: Error
    
    init(from networkError: NetworkError) {
        cause = networkError
        switch networkError {
        case .connectionError:
            messageKey = "connectionError"
        case .noConnection:
            messageKey = "noConnectionError"
        case .invalidUrl:
            messageKey = "internalError"
        }
    }
}


