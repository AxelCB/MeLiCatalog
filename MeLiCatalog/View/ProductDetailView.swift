//
//  ProductDetailView.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 06/04/2021.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    
    init(product: Product) {
        viewModel = ProductDetailViewModel(productId: product.id)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            Text(viewModel.productDetail?.title ?? "")
                .font(.headline)
                .padding(.horizontal)
                .onAppear {
                    viewModel.loadProductDetail()
                }

            if !viewModel.isLoading {
                CarouselView(items: viewModel.imageUrls) { imageUrlString in
                    Group {
                        if let imageUrl = URL(string: imageUrlString),
                           let imageData = try? Data(contentsOf: imageUrl),
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .cornerRadius(5)

                        } else {
                            Image("NotAvailable")
                                .frame(height: 300)
                                .cornerRadius(5)
                        }
                    }
                    .padding(.bottom, 45)
                }
                .frame(maxHeight: 350)
            }
            Text(viewModel.productDetail?.description ?? "")
                .padding()
            
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [] )
        .overlay(
            Group {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        )
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.EXAMPLE)
    }
}
