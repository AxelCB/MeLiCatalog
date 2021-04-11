//
//  ProductDetailView.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 06/04/2021.
//

import SwiftUI

struct ProductDetailView: View {
    let viewModel: ProductDetailViewModel
    
    init(product: Product) {
        viewModel = ProductDetailViewModel(productId: product.id)
    }
    
    var body: some View {
        Text(viewModel.product.title)
            .onAppear {
                viewModel.loadProductDetail()
            }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.EXAMPLE)
    }
}
