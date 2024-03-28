//
//  Home.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import SwiftUI

struct Home: View {
    @State var selectedCategory = ""
    
    var body: some View {
        ZStack{
            // background color
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            
            
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
                                Text("\(category.title)'s Collection")
                                    .font(.title2)
                                    .fontDesign(.rounded)
                                    .tracking(1.2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black.opacity(0.7))
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .foregroundStyle(.black.opacity(0.7))
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal, 32)
                            
                            
                            // Product List
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(sampleProductList) { product in
                                        ProductCardView(product: product)
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
    Home()
}

