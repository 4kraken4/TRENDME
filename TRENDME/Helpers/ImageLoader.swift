//
//  ImageLoader.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-30.
//

import SwiftUI
import Kingfisher

struct ImageLoader: View {
    let url: URL?
    let placeholder: Image
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }
    
    var body: some View {
        KFImage(url)
            .placeholder {
                placeholder
                    .resizable()
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
    }
}
