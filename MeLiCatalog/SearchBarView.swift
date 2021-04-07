//
//  SearchBarView.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 06/04/2021.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchTerm: String
    @State var isSearching: Bool = false
    
    var body: some View {
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
    }
}
