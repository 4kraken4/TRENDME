//
//  CartViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-28.
//

import Foundation

class CartViewModel : ObservableObject {
    @Published private(set) var products: [ProductModel] = []
    @Published private(set) var total: Double = 0
    
    func addToCart(product: ProductModel) {
        products.append(product)
        total += product.unitPrice
    }
    
    func removeFromCart(product: ProductModel) {
        products = products.filter { $0.id != product.id}
        total -= product.unitPrice
    }
}
