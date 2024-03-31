//
//  Home.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI

struct HomeView: View {
    @State var selectedCategory = ""
    @StateObject var cartVM: CartViewModel = CartViewModel()
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    
    
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
                                        .foregroundStyle(Color.white)
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
                        
                        ForEach(homeVM.itemCollections.indices, id: \.self) { index in
                            let collection = homeVM.itemCollections[index]
                            if !"\(collection.id)".localizedCaseInsensitiveContains("all") {
                                VStack {
                                    HStack {
                                        Text("\(collection.id.localizedCapitalized)'s Collection")
                                            .font(.title2)
                                            .fontDesign(.rounded)
                                            .tracking(1.2)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.black.opacity(0.7))
                                        
                                        Spacer()
                                        
                                        NavigationLink {
                                            CollectionView(selectedCategory: collection.id)
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
                                            ForEach(collection.items) { item in
                                                ProductCardView(item: item.toItem())
                                                    .environmentObject(cartVM)
                                            }
                                        }
                                        
                                    }
                                    .scrollIndicators(.hidden)
                                    .padding(.bottom, 32)
                                    
                                    
                                }
                                
                                Divider()
                            }
                        }
                        
                        
                    })
                    
                    
                }
            }
            
            if cartVM.items.count > 0 {
                
                NavigationLink(destination: CartView().environmentObject(cartVM)) {
                    
                    HStack(spacing: 30) {
                        Text("\(cartVM.items.count)")
                            .padding()
                            .background(.yellow)
                            .clipShape(.circle)
                            .foregroundColor(.black)
                        
                        VStack(alignment: .leading) {
                            Text("Cart")
                                .font(.system(size: 26, weight: .semibold))
                            
                            Text("\(cartVM.items.count) items")
                                .font(.system(size: 18))
                        }
                        
                        Spacer()
                        
                        ForEach (cartVM.items, id: \.id) {item in
                            ImageLoader(url: URL(string: item.image), placeholder: Image("5456_2"))
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
        .onAppear(perform: {
            homeVM.fetchTrendingCollections()
        })
        .ignoresSafeArea(edges: .bottom)
    }
    
    
    var categoryListView : some View {
        HStack ( alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content:{
            ScrollView(.horizontal) {
                HStack {
                    ForEach (homeVM.itemCollections.indices, id: \.self) { index in
                        let cat = homeVM.itemCollections[index]
                        Button {
                            selectedCategory = cat.id
                        } label: {
                            HStack {
                                Text(cat.id)
                                    .font(.system(size: 16))
                                    .fontDesign(.rounded)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 8)
                            .background (
                                selectedCategory == cat.id ? .white : Color.black.opacity(0.3)
                            )
                            .foregroundStyle(selectedCategory == cat.id ? .blue : .black.opacity(0.7))
                            
                            .clipShape(.capsule)
                            .clipped(antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
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

