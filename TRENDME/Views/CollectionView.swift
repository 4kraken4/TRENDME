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
    @StateObject private var searchVM = SearchViewModel()
    @Environment (\.presentationMode) var mode
    @State var selectedCategory: String = "All"
    @StateObject var collectionVM: CollectionViewModel = CollectionViewModel()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        HStack(alignment: .center, spacing: 12) {
                            
                            HStack(alignment: .center, spacing: 12) {
                                
                                TextField(text: $searchVM.searchString) {
                                    Text("Search here")
                                        .font(.title3)
                                        .fontDesign(.rounded)
                                }
                                .userActivity("Activity", { activity in
                                    if searchVM.searchString.isEmpty {
                                        searchVM.clearResult()
                                    }
                                })
                                
                                
                                Image(systemName: "magnifyingglass")
                                    .font(.title)
                                    .foregroundStyle(.gray.opacity(0.7))
                                    .onTapGesture {
                                        searchVM.search(category: selectedCategory)
                                    }
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
                                Text("Tags")
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
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        
                        if !searchVM.searchString.isEmpty && !searchVM.result.isEmpty {
                            ForEach(searchVM.result) { i in
                                SmallProductCardView(item: i)
                                    .environmentObject(cartVM)
                            }
                        } else {
                            ForEach(collectionVM.itemCollections) { i in
                                SmallProductCardView(item: i)
                                    .environmentObject(cartVM)
                            }
                        }
                        
                        
                    }
                }
                
            }
        }
        .onAppear(perform: {
            self.collectionVM.fetchCollection(category: self.selectedCategory)
        })
    }
    
    func filteredProducts() -> [Item] {
        if selectedCategory == "All" {
            return collectionVM.itemCollections
        } else {
            return collectionVM.itemCollections.filter { $0.category.rawValue == selectedCategory }
        }
    }
}

#Preview {
    CollectionView()
        .environmentObject(CartViewModel())
}
