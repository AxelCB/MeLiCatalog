//
//  ProductRow.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 07/04/2021.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    
    var body: some View {
        HStack (spacing: 8) {
            if let imageUrl = URL(string: product.imageUrl),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .cornerRadius(25)
            } else {
                Image("person")
            }
            VStack (alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.subheadline)
                Text("\(product.formattedPrice)")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            .padding()
        }
        .padding()
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product.EXAMPLE)
    }
}
