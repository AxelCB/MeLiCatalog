//
//  ImageCarousel.swift
//  MeLiCatalog
//
//  Created by Axel Collard Bovy on 11/04/2021.
//

import SwiftUI

struct CarouselView<Data, Content>: View where Data: RandomAccessCollection, Data.Element: Hashable, Content: View {
    let items: Data
    let content: (Data.Element) -> Content
    
    var body: some View {
        TabView {
            ForEach(items, id: \.self) { item in
                content(item)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

