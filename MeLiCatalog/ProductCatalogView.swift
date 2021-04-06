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
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.secondary)
                    TextField("search", text: $searchTerm)
                }
                .padding()
                .background(Color(.systemGray4))
                .cornerRadius(15)
                .padding(.horizontal)
                
                ForEach(products, id: \.self) {
                    Text($0)
                }
            }
            .navigationTitle("products")
        }
    }
}

struct ProductCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCatalogView()
    }
}
