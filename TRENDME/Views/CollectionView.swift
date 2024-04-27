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
    @State private var showSearchFilterView: Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        
                        HStack(alignment: .bottom) {
                            Spacer()
                            if cartVM.items.count > 0 {
                                NavigationLink(destination: CartView().environmentObject(cartVM)) {
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
                            }
                        }
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
                                        if searchVM.applyFilters {
                                            searchVM.searchWithFilters(category: selectedCategory)
                                        } else {
                                            if !searchVM.searchString.isEmpty {
                                                searchVM.search(category: selectedCategory)
                                            }
                                        }
                                    }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 12)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.black.opacity(0.1))
                            }
                            
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.title)
                                .onTapGesture {
                                    showSearchFilterView.toggle()
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        
                        if !searchVM.result.isEmpty {
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
                .sheet(isPresented: $showSearchFilterView, onDismiss: {
                    
                }, content: {
                    if #available(iOS 16.4, *) {
                        SearchFilterView()
                            .presentationDetents([.height(600)])
                            .presentationCornerRadius(30)
                            .environmentObject(searchVM)
                    } else {
                        SearchFilterView()
                            .presentationDetents([.height(600)])
                            .environmentObject(searchVM)
                    }
                })
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
