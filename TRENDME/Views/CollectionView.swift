//
//  Collection.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI
import UIKit

struct CollectionView: View {
    @EnvironmentObject var cartVM : CartViewModel
    @Environment (\.presentationMode) var mode
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    HStack(alignment: .center, content: {
                        
                        Text("Discover the true **Fashion**")
                            .font(.system(size: 36))
                            .multilineTextAlignment(.leading)
                            .fontDesign(.rounded)
                        
                    })
                    .padding()
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(sampleProductList, id: \.id) { item in
                            SmallProductCardView(product: item)
                                .environmentObject(cartVM)
                        }
                    }
                    
                }
            }
        }
        
        
    }
}

#Preview {
    CollectionView()
        .environmentObject(CartViewModel())
}


struct SmallProductCardView : View {
    @EnvironmentObject var cartVM: CartViewModel
    
    var product: ProductModel
    var cardColor: Color = Color.orange
    
    init(product: ProductModel) {
            self.product = product
            
            if let image = UIImage(named: product.image.replacingOccurrences(of: ".jpg", with: "")) {
                let averageColor = image.averageColor()
                let enhancedColor = averageColor.enhanced()
                self.cardColor = Color(enhancedColor)
            } else {
                self.cardColor = Color.orange // Fallback color if image is not available
            }
        }
    
    var body: some View {
        ZStack {
            
            Image(product.image.replacingOccurrences(of: ".jpg", with: ""))
                .resizable()
                .scaledToFit()
                .scaleEffect(0.7)
                .rotationEffect(Angle(degrees: 0))
                .blendMode(.multiply)
                .offset(x: 40, y: -30)
            
            ZStack {
                VStack(alignment: .leading) {
                    Text("\(product.name)")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 70)
                        .foregroundStyle(.white)
                        .padding(.bottom, 0)
                        .fontDesign(.rounded)
                        .blendMode(.difference)
                    
                    Text("\(product.category)")
                        .font(.system(size: 12))
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.black.opacity(0.5))
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    
                    Spacer()
                    
                    HStack {
                        Text("$\(product.unitPrice.formatted())")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            cartVM.addToCart(product: product)
                        } label: {
                            Image(systemName: "basket")
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
        .background(cardColor.opacity(0.6))
        .clipShape(.rect(cornerRadius: 30))
    }
}
