//
//  ProductRow.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 07/04/2021.
//

import SwiftUI

struct ProductRow: View {
    let product: String
    
    var body: some View {
        HStack {
            if let imageUrl = URL(string: product),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
            } else {
                Image("person")
            }
            VStack {
                Text(product)
                Text(product)
            }
            Text(product)
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: "Sample Product")
    }
}
