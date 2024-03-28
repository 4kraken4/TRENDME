//
//  ProductCardView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI

struct ProductCardView: View {
    var product: ProductModel
    var body: some View {
        ZStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            VStack(content: {
                
                Image("login-image")
                    .scaleEffect(0.3)
                    .frame(width:284, height: 314)
                    .clipShape(.rect(cornerRadius: 54))
                
                HStack {
                    Text(product.name)
                        .font(.system(size: 24))
                        .fontDesign(.rounded)
                        .tracking(1.2)
                }
                
            })
        })
        .frame(width: 336, height: 422)
        .background {
            RoundedRectangle(cornerRadius: 54)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ProductCardView(product: ProductModel(itemCode: "I001", name: "Cool Summer Shirt", category: "Men", unitPrice: 59.99, image: "MIG001"))
}

