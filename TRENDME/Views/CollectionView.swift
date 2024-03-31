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
    @State var selectedCategory: String = "All"
    @StateObject var collectionVM: CollectionViewModel = CollectionViewModel()
    
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
                        
                        ForEach(collectionVM.itemCollections) { i in
                            SmallProductCardView(item: i)
                                .environmentObject(cartVM)
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
