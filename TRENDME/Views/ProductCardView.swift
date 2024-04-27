//
//  ProductCardView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI
import CoreImage
import UIKit
import Kingfisher

struct ProductCardView: View {
    @State var showConfirmation : Bool = false
    @EnvironmentObject var cartVM: CartViewModel
    @StateObject private var viewModel: ProductCardViewModel
    var item: Item
    
    init(item: Item) {
        self.item = item
        _viewModel = StateObject(wrappedValue: ProductCardViewModel())
    }
    
    var body: some View {
        ZStack {
            
            ImageLoader(url: URL(string: item.image), placeholder: Image("5456_2"))
                .scaledToFit()
                .scaleEffect(0.8)
                .rotationEffect(Angle(degrees: 0))
                .blendMode(.multiply)
                .offset(x: 50, y: -30)
            
            ZStack {
                VStack(alignment: .leading) {
                    Text("\(item.name)")
                        .font(.system(size: 36, weight: .semibold))
                        .frame(width: 140)
                        .foregroundStyle(.white)
                        .padding(.bottom, 0)
                        .fontDesign(.rounded)
                        .blendMode(.difference)
                    
                    Text("\(item.category.rawValue)")
                        .font(.callout)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.black.opacity(0.5))
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                    Spacer()
                    
                    HStack {
                        Text("Rs.\(item.unitPrice.formatted())")
                            .font(.system(size: 27, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            self.showConfirmation.toggle()
                        } label: {
                            Image(systemName: "cart")
                                .imageScale(.large)
                                .frame(width: 90, height: 68)
                                .background(.black)
                                .clipShape(.capsule)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, -10)
                        .alert(isPresented: $showConfirmation) {
                              Alert(
                                title: Text("Confirm Action"),
                                message: Text("Are you sure you want to add this item to cart?"),
                                primaryButton: .destructive(Text("Yes"), action: handleAddToCart),
                                secondaryButton: .cancel()
                              )
                            }
                    }
                    .padding(.leading)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.white.opacity(0.9))
                    .clipShape(.capsule)
                }
            }.padding(30)
                .frame(width: 336, height: 422)
        }
        .frame(width: 336, height: 422)
        .background(viewModel.cardColor.opacity(0.6))
        .clipShape(.rect(cornerRadius: 57))
        .padding(.leading, 20)
        .onAppear {
            viewModel.loadImage(from: item.image)
        }
    }
    func handleAddToCart() {
        cartVM.addToCart(item: item)
      }
}




#Preview {
    ProductCardView(item: Item(id: "", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men))
        .environmentObject(CartViewModel())
        
}
