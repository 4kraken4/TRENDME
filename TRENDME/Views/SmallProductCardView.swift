//
//  SmallProductCardView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-31.
//

import SwiftUI
import UIKit

struct SmallProductCardView : View {
    @EnvironmentObject var cartVM: CartViewModel
    @StateObject var viewModel: ProductCardViewModel
    var item: Item
    
    init(item: Item) {
        self.item = item
        _viewModel = StateObject(wrappedValue: ProductCardViewModel())
    }
    
    var body: some View {
        ZStack {
            
            ImageLoader(url: URL(string: item.image), placeholder: Image("5456_2"))
                .scaledToFit()
                .scaleEffect(0.7)
                .rotationEffect(Angle(degrees: 0))
                .blendMode(.multiply)
                .offset(x: 40, y: -30)
            
            
            ZStack {
                VStack(alignment: .leading) {
                    Text("\(item.name)")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 70)
                        .foregroundStyle(.white)
                        .padding(.bottom, 0)
                        .fontDesign(.rounded)
                        .blendMode(.difference)
                    
                    Text("\(item.category.rawValue.localizedCapitalized)")
                        .font(.system(size: 12))
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.black.opacity(0.5))
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                    Spacer()
                    
                    HStack {
                        Text("$\(item.unitPrice.formatted())")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            cartVM.addToCart(item: item)
                        } label: {
                            Image(systemName: "cart")
                                .imageScale(.large)
                                .frame(width: 45, height: 40)
                                .background(.black)
                                .clipShape(.capsule)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.trailing, -12)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(.white.opacity(0.9))
                    .clipShape(.capsule)
                }
            }.padding(20)
                .frame(width: 170, height: 215)
        }
        .frame(width: 170, height: 215)
        .background(viewModel.cardColor.opacity(0.6))
        .clipShape(.rect(cornerRadius: 30))
        .onAppear(perform: {
            viewModel.loadImage(from: item.image)
        })
    }
}

#Preview {
    SmallProductCardView(item: Item(id: "", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men))
        .environmentObject(CartViewModel())
}
