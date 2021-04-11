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
        HStack (alignment: .center, spacing: 8) {
            if let imageUrl = URL(string: product.imageUrl),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .frame(width: 90, height: 90)
                    .cornerRadius(25)
            } else {
                Image("NotAvailable")
                    .frame(width: 90, height: 90)
                    .cornerRadius(25)
            }
            VStack (alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                Text("\(product.formattedPrice)")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            .padding()
            Spacer()
        }
        .padding(.horizontal)
        .redacted(reason: product.id.isEmpty ? .placeholder : [])
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product.EXAMPLE)
    }
}
