//
//  CartViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-28.
//

import Foundation

class CartViewModel : ObservableObject {
    @Published private(set) var items: [Item] = []
    @Published private(set) var total: Double = 0
    
    func addToCart(item: Item) {
        items.append(item)
        total += item.unitPrice
    }
    
    func removeFromCart(item: Item) {
        items = items.filter { $0.itemID != item.itemID }
        total = items.reduce(0) { $0 + $1.unitPrice }
    }
}
