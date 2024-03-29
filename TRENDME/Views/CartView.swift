//
//  CartView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-28.
//

import SwiftUI

struct CartView: View {
    
    @Environment (\.presentationMode) var mode
    @EnvironmentObject var cartVM: CartViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Cart")
                            .font(.largeTitle)
                            .padding(.trailing)
                        
                        Spacer()
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Text("\(cartVM.products.count)")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .background(.blue)
                                .clipShape(.capsule)
                        }
                        .foregroundStyle(.black)
                        
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Text("3")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .overlay(Capsule().stroke())
                        }
                        .foregroundStyle(.black)
                    }
                    .padding(30)
                    
                    
                    VStack {
                        ForEach (cartVM.products, id: \.name) {item in
                            CartProductView(product: item)
                        }
                    }.padding(.horizontal)
                    
                    
                    
                    // Card total
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Delivery Amount")
                            Spacer()
                            Text("Free")
                                .font(.system(size: 24, weight: .semibold))
                                .fontDesign(.rounded)
                        }
                        
                        Divider()
                        
                        Text("Total Amount")
                            .font(.system(size: 24))
                        
                        Text("USD \(cartVM.total.formatted())")
                            .font(.system(size: 36, weight: .semibold))
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 30))
                    .padding()
                    
                    
                    
                    // Button
                    
                    Button{
                        
                    } label: {
                        Text("Make Payment")
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .frame(height: 80)
                            .background(.blue.opacity(0.5))
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.black)
                            .clipShape(.capsule)
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}


struct CartProductView : View {
    var product: ProductModel
    
    var body : some View {
        HStack(alignment: .center, spacing: 20) {
            Image(product.image.replacingOccurrences(of: ".jpg", with: ""))
                .resizable()
                .scaledToFit()
                .scaleEffect(2.1)
                .padding()
                .frame(width: 80, height: 80)
                .background(.gray.opacity(0.25))
                .clipShape(.circle)
                .blendMode(.multiply)
                .softOuterShadow()
            
            VStack(alignment: .leading, spacing: 0) {
                Text(product.name)
                    .font(.system(size: 16))
                    .fontDesign(.rounded)
                
                Text(product.category)
                    .font(.callout)
                    .opacity(0.5)
                    .fontDesign(.rounded)
                                
            }
            
            Spacer()
            
            Text( "\(product.unitPrice.formatted())")
                .padding()
                .background(.yellow)
                .clipShape(.capsule)
                .font(.system(size: 13))
        }
    }
}
