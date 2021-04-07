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
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search", text: $searchTerm)
                            .onTapGesture {
                                isSearching = true
                            }
                        if isSearching {
                            Button(action: { searchTerm = "" }, label: {
                                Image(systemName: "xmark.circle.fill")
                            })
                            .transition(.move(edge: .trailing))
                            .animation(.easeInOut)
                        }
                    }
                    .foregroundColor(Color.secondary)
                    .padding(8)
                    .background(Color(.systemGray4))
                    .cornerRadius(15)
                    .padding(isSearching ? .leading : .horizontal)
                    
                    if isSearching {
                        Button("cancel") {
                            searchTerm = ""
                            isSearching = false
                            
                            UIApplication.shared
                                .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .padding(.trailing)
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut)
                    }
                }
                
                
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        Text(product)
                    }
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
