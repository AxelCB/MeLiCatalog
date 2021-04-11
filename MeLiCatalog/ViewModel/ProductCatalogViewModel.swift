//
//  ProductCatalogViewModel.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 07/04/2021.
//

import Foundation
import Combine
import SwiftUI

class ProductCatalogViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published var searchTerm = ""
    @Published var isLoading = false
    
    private var subscription: Set<AnyCancellable> = []
    private var currentPage = Page(offset: 0)
    
    init() {
        $searchTerm
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.count > 3 }
            .map({ (string) -> String? in
                let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmedString.count < 1 {
                    self.isLoading = false
                    return nil
                }
                
                return trimmedString
            })
            .compactMap{ $0 }
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                self.isLoading = true
                self.products = []
                UIApplication.shared
                    .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                searchProducts(forTerm: searchField)
            }.store(in: &subscription)
    }
    
    private func searchProducts(forTerm term: String) {
        ProductService.shared.getNextPageFrom(currentPage, withSearchTerm: term)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Success")
                }
            } receiveValue: { paginatedResponse in
                self.isLoading = false
                self.products.append(contentsOf: paginatedResponse.results)
                self.currentPage = paginatedResponse.paging
            }.store(in: &subscription)

    }
}
