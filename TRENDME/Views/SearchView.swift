//
//  SearchView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-06.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    @EnvironmentObject var router: TabRouter
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                HStack(alignment: .center, spacing: 12) {
                    
                    HStack(alignment: .center, spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundStyle(.gray.opacity(0.7))
                        
                        TextField(text: $searchVM.searchString) {
                            Text("Search here")
                                .font(.title3)
                            
                            .fontDesign(.rounded)                    }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.black.opacity(0.1))
                    }
                    
                    Image(systemName: "cart")
                        .font(.title)
                }
                
                HStack (alignment: .center, spacing: 32) {
                    Text("Filters")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    
                    LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, content: {
                        Text("Price")
                            .font(.system(size: 12))
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(8)
                            .padding(.horizontal, 8)
                            .background {
                                Color.black.opacity(0.1)
                            }
                            .clipShape(.capsule)
                        Text("Gender")
                            .font(.system(size: 12))
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(8)
                            .padding(.horizontal, 8)
                            .background {
                                Color.black.opacity(0.1)
                            }
                            .clipShape(.capsule)
                        Text("All")
                            .font(.system(size: 12))
                            .foregroundStyle(.blue.opacity(0.7))
                            .padding(8)
                            .padding(.horizontal, 8)
                            .background {
                                Color.black.opacity(0.0)
                            }
                            .clipShape(.capsule)
                            .overlay {
                                Capsule()
                                    .stroke(lineWidth: 1)
                                    .foregroundStyle(.blue)
                            }
                        
                    })
                    
                    Spacer()
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title)
                }
                
                VStack(alignment: .leading) {
                    Text("Mens T-Shirts")
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .padding(.bottom)
                    
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        SmallProductCardView(item: Item(id: "", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men))
                        SmallProductCardView(item: Item(id: "", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men))
                        SmallProductCardView(item: Item(id: "", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men))
                        SmallProductCardView(item: Item(id: "", itemID: 1, name: "Long sleeved shirt", image: "4995.jpg", unitPrice: 29.99, description: "The best for youth", tags: ["men", "trending"], category: Category.men))
                        
                    }
                    
                }
                
                Spacer()
            }
            .padding(24)
        }
    }
    
}

#Preview {
    SearchView()
        .environmentObject(TabRouter())
}
