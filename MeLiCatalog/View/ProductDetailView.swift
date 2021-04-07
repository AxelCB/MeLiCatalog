//
//  ProductDetailView.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 06/04/2021.
//

import SwiftUI

struct ProductDetailView: View {
    let product: String
    
    var body: some View {
        Text(product)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: "Sample product")
    }
}
