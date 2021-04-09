//
//  ProductCatalogViewModel.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 07/04/2021.
//

import Foundation
import Combine

class ProductCatalogViewModel: ObservableObject {
    @Published private(set) var products: [Product] = Array.init(repeating: Product.EXAMPLE, count: 15)
    @Published var searchTerm = ""
    @Published var isLoading = false
    
    private var subscription: Set<AnyCancellable> = []
    
    init() {
        $searchTerm
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.isLoading = false
                    return nil
                }
                
                return string
            })
            .compactMap{ $0 }
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                print(searchField)
                self.isLoading = true
                //searchItems(searchText: searchField)
            }.store(in: &subscription)
    }
}
