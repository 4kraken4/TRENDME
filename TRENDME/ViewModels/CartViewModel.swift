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
    private let apiService = APIService.shared
    @Published var cart: CartModelResponse?
    @Published var paymentCompleted: Bool = false
    @Published var order: Order?
    
    func addToCart(item: Item) {
        items.append(item)
        total += item.unitPrice
        upsertCart()
    }
    
    func removeFromCart(item: Item) {
        items = items.filter { $0.itemID != item.itemID }
        total = items.reduce(0) { $0 + $1.unitPrice }
        if !items.isEmpty {
            upsertCart()
        } else {
            deleteCart()
        }
    }
    
    private func deleteCart() {
        if let cartId = cart?.cartModelID {
            apiService.deleteData(endpoint: "/cart/\(cartId)") { (result:Result<CartModelResponse, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.cart = nil
                        self.items.removeAll()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    private func upsertCart() {
        if self.cart != nil {
            if let cartId = cart?.cartModelID {
                apiService.putData(endpoint: "/cart/\(cartId)", body: CartModel(id: 1, items: items, status: false)) { (result: Result<CartModelResponse, Error>) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let cart):
                            self.cart = cart
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            apiService.postData(endpoint: "/cart", body: CartModel(id: 1, items: items, status: false)) { (result: Result<CartModelResponse, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let cart):
                        guard let items = Optional(cart.items) else {
                            return
                        }
                        self.cart = cart
                        self.items = items
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchCartData() {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        apiService.fetchData(endpoint: "/cart/user/\(userId)") { (result: Result<CartModelResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    guard let items = Optional(cart.items) else {
                        return
                    }
                    self.items = items
                    guard let cart = Optional(cart.self) else {
                        return
                    }
                    self.cart = cart
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func makeOrder() {
        self.paymentCompleted = false
        if let cart = self.cart {
            self.apiService.postData(endpoint: "/order", body: OrderRequest(userId: cart.userID, cartId: cart.cartModelID, total: self.total)) { (result: Result<Order, Error>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let order):
                        guard let order = Optional(order.self) else {
                            return
                        }
                        self.order = order
                        self.cart = nil
                        self.items.removeAll()
                        self.paymentCompleted = true
                        self.total = 0
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                    }
                }
            }
        }
    }
}
