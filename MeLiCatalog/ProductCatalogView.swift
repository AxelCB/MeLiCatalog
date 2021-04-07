//
//  ContentView.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 06/04/2021.
//

import SwiftUI

struct ProductCatalogView: View {
    @State var products: [String] = Array(1..<50).map {String($0) }
    @State var searchTerm = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBarView(searchTerm: $searchTerm)
                    .padding()
                
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRow(product: product)
                    }
                }
            }
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
