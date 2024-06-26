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
    @State var selectedTab : Tab = Tab.home
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            ZStack (alignment: Alignment(horizontal: .trailing, vertical: .top)){
                
                NavigationView {
                    ScrollView {
                        VStack (alignment: .leading, content: {
                            HStack(alignment: .center, content: {
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
                .navigationBarBackButtonHidden(true)
                
                if (cartVM.items.count > 0) {
                    
                    NavigationLink(destination: CartView().environmentObject(cartVM)) {
                        
                        HStack(spacing: 30) {
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                                Text("\(cartVM.items.count)")
                                    .padding(10)
                                    .background(.red.opacity(0.8))
                                    .font(.system(size: 11))
                                    .clipShape(.circle)
                                    .foregroundColor(.white)
                                    .offset(x:-15 , y:-20)
                                
                                Image(systemName: "cart.fill")
                                    .font(.title)
                                    .foregroundStyle(.black.opacity(0.8))
                            }
                            
                        }
                        .padding(30)
                        .padding(.top, 18)
                        .frame(height: 75)
                        .background(.white)
                        .clipShape(.circle)
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.top, 64)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0)
                    }
                }
            }
            .onAppear(perform: {
                homeVM.fetchTrendingCollections()
                cartVM.fetchCartData()
            })
            
            BottomNav(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .all)
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
}

