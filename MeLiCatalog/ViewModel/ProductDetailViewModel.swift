//
//  ProductDetailViewModel.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 10/04/2021.
//

import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {
    @Published var productDetail: ProductDetail?
    @Published var isLoading = true
    
    let productId: String
    private var subscription: Set<AnyCancellable> = []
    
    var product: ProductDetail {
        productDetail ?? ProductDetail.EXAMPLE
    }
    
    var imageUrls: [String] {
        productDetail?.pictures.map { $0.url } ?? []
    }
    
    init(productId: String) {
        self.productId = productId
    }
    
    func loadProductDetail() {
        ProductService.shared
            .loadProduct(withId: productId)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    debugPrint("Finished getting products detail")
                }
            } receiveValue: { productDetail in
                self.isLoading = false
                self.productDetail = productDetail
            }.store(in: &subscription)
    }
}
