//
//  SearchFilterView.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-24.
//

import SwiftUI

struct SearchFilterView: View {
    
    @State private var width: CGFloat = 0
    @State private var width2: CGFloat = 15
    var totalWidth = UIScreen.main.bounds.width - 100
    @EnvironmentObject var searchVM: SearchViewModel

    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 100, height: 2)
                .foregroundColor(.blue)
            
            ScrollView {
                VStack (alignment: .leading, spacing: 32) {
                    VStack (alignment: .leading) {
                        Toggle(isOn: $searchVM.applyFilters) {
                            Text("Apply Filters")
                                .font(.title2)
                        }
                        Text("Price Range")
                            .font(.title2)
                        
                        // Range Selector
                        
                        Text("Range: (Rs) \(self.getValue(val: self.width / self.totalWidth)) - \(self.getValue(val: self.width2 / self.totalWidth))")
                            .hSpacing()
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .fill(Color.black.opacity(0.2))
                                .frame(height: 2)
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: self.width2 - self.width, height: 4)
                                .offset(x: self.width + 22)
                            
                            HStack(spacing: 0) {
                                Circle()
                                    .fill(Color.range)
                                    .stroke(.blue)
                                    .shadow(color: .black.opacity(0.1), radius: 5, y: 0.0)
                                    .frame(width: 22, height: 22)
                                    .offset(x: self.width)
                                    .gesture(DragGesture()
                                        .onChanged({ (value) in
                                            if value.location.x >= 0 && value.location.x <= self.width2 {
                                                self.width = value.location.x
                                                self.searchVM.selectedLowerPrice = self.getValue(val: self.width / self.totalWidth)
                                            }
                                        }))
                                
                                Circle()
                                    .fill(Color.range)
                                    .stroke(.blue)
                                    .shadow(color: .black.opacity(0.1), radius: 10, y: 0.0)
                                    .frame(width: 22, height: 22)
                                    .offset(x:self.width2)
                                    .gesture(DragGesture()
                                        .onChanged({ (value) in
                                            if value.location.x <= self.totalWidth && value.location.x >= self.width {
                                                self.width2 = value.location.x
                                                self.searchVM.selectedUpperPrice = self.getValue(val: self.width2 / self.totalWidth)
                                            }
                                        })
                                    )
                            }
                        }
                        .padding()
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Categories")
                            .font(.title2)
                        
                        Text("Select all categories you wish to search within")
                        
                        HStack {
                            Text("Men")
                                .font(.system(size: 12))
                                .foregroundStyle(.black.opacity(0.7))
                                .padding(8)
                                .padding(.horizontal, 8)
                                .background {
                                    Color.black.opacity(0.1)
                                }
                                .clipShape(.capsule)
                            Text("Wemen")
                                .font(.system(size: 12))
                                .foregroundStyle(.black.opacity(0.7))
                                .padding(8)
                                .padding(.horizontal, 8)
                                .background {
                                    Color.black.opacity(0.1)
                                }
                                .clipShape(.capsule)
                            Text("Kids")
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
                        }
                        .hSpacing()
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Brand")
                            .font(.title2)
                        
                        Text("Select all categories you wish to search within")
                        
                        HStack {
                            Text("Brand 1")
                                .font(.system(size: 12))
                                .foregroundStyle(.black.opacity(0.7))
                                .padding(8)
                                .padding(.horizontal, 8)
                                .background {
                                    Color.black.opacity(0.1)
                                }
                                .clipShape(.capsule)
                            Text("Brand 2")
                                .font(.system(size: 12))
                                .foregroundStyle(.black.opacity(0.7))
                                .padding(8)
                                .padding(.horizontal, 8)
                                .background {
                                    Color.black.opacity(0.1)
                                }
                                .clipShape(.capsule)
                            Text("Brand 3")
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
                        }
                        .hSpacing()
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
    
    func getValue(val: CGFloat) -> Int {
        return Int((val*4000).rounded())
    }
}

#Preview {
    SearchFilterView()
        .environmentObject(SearchViewModel())
}
