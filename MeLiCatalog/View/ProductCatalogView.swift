//
//  ProductCatalogView.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 06/04/2021.
//

import SwiftUI

struct ProductCatalogView: View {
    @ObservedObject var viewModel = ProductCatalogViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBarView(searchTerm: $viewModel.searchTerm)
                    .padding()
                ForEach(viewModel.products, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(product: product.title)) {
                        ProductRow(product: product)
                            .redacted(reason: viewModel.isLoading ? .placeholder : [])
                    }.buttonStyle(PlainButtonStyle())
                }
            }.overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            )
            .navigationTitle("products")    
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ProductCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCatalogView()
    }
}
