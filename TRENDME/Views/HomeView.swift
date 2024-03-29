//
//  Home.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI

struct HomeView: View {
    @State var selectedCategory = ""
    @StateObject var cartVM = CartViewModel()
    
    var body: some View {
        ZStack (alignment: .bottom){
            NavigationView {
                ScrollView {
                    VStack (alignment: .leading, content: {
                        HStack(alignment: .center, content: {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                                .frame(width: 56, height: 56)
                                .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .foregroundStyle(Color.Neumorphic.main)
                                    .softOuterShadow()
                                )
                                .padding(.trailing, 32)
                            
                            
                            Text("Discover the true **Fashion**")
                                .font(.system(size: 36))
                                .multilineTextAlignment(.leading)
                                .fontDesign(.rounded)
                            
                        })
                        .padding()
                        
                        // Category list
                        categoryListView
                            .padding(.bottom, 16)
                        
                        
                        // Collections
                        ForEach(categoryList) { category in
                            if !category.title.localizedCaseInsensitiveContains("all") {
                                HStack {
                                    Text("\(category.title) Collection")
                                        .font(.title2)
                                        .fontDesign(.rounded)
                                        .tracking(1.2)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black.opacity(0.7))
                                    
                                    Spacer()
                                    
                                    NavigationLink {
                                        CollectionView()
                                            .environmentObject(cartVM)
                                    } label: {
                                        Image(systemName: "arrow.right")
                                            .foregroundStyle(.black.opacity(0.7))
                                            .font(.title2)
                                            .fontWeight(.bold)
                                    }
                                    
                                }
                                .padding(.horizontal, 32)
                                
                                
                                // Product List
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(sampleProductList) { product in
                                            ProductCardView(product: product)
                                                .environmentObject(cartVM)
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .padding(.bottom, 32)
                                
                                Divider()
                            }
                        }
                        
                    })
                    
                    
                }
            }
            
            if cartVM.products.count > 0 {
                
                NavigationLink(destination: CartView().environmentObject(cartVM)) {
                    
                    HStack(spacing: 30) {
                        Text("\(cartVM.products.count)")
                            .padding()
                            .background(.yellow)
                            .clipShape(.circle)
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Cart")
                                .font(.system(size: 26, weight: .semibold))
                            
                            Text("\(cartVM.products.count) items")
                                .font(.system(size: 18))
                        }
                        
                        Spacer()
                        
                        ForEach (cartVM.products, id: \.id) {product in
                                Image(product.image.replacingOccurrences(of: ".jpg", with: ""))
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(1.5)
                                .padding(8)
                                .frame(width: 60, height: 60)
                                .background(.white)
                                .clipShape(.circle)
                                .padding(.leading, -60)
                        }
                        
                    }
                    .padding(30)
                    .frame(width: .infinity, height: 100)
                    .background(.black)
                    .clipShape(.rect(topLeadingRadius: 40, topTrailingRadius: 40))
                    .foregroundStyle(.white)
                    
                }
                 
            }
    }
        .ignoresSafeArea(edges: .bottom)
}
    
    
    var categoryListView : some View {
        HStack ( alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content:{
            ScrollView(.horizontal) {
                HStack {
                    ForEach (categoryList, id: \.id) { item in
                        Button {
                            selectedCategory = item.title
                        } label: {
                            HStack {
                                if !item.icon.isEmpty {
                                    Image(item.icon)
                                }
                                Text(item.title)
                                    .font(.system(size: 16))
                                    .fontDesign(.rounded)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 8)
                            .background (
                                selectedCategory == item.title ? .white : Color.Neumorphic.main
                            )
                            .foregroundStyle(selectedCategory == item.title ? .blue : .black.opacity(0.7))
                            
                            .clipShape(.capsule)
                            .clipped(antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .softOuterShadow()
                            .padding(.vertical)
                        }
                        .padding(.leading)
                    }
                }
            }.scrollIndicators(.hidden)
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(CartViewModel())
}

