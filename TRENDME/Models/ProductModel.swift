//
//  ProductModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import Foundation

struct ProductModel : Identifiable {
    var id: UUID = .init()
    var itemCode: String
    var name: String
    var category: String
    var unitPrice: Double
    var image: String
}

var sampleProductList: [ProductModel] = [
    ProductModel(itemCode: "I001", name: "Cool Summer Shirt", category: "Mens", unitPrice: 59.99, image: "5456_2.jpg"),
    ProductModel(itemCode: "I002", name: "Cool Summer Pant", category: "Mens", unitPrice: 109.99, image: "5655.jpg"),
    ProductModel(itemCode: "I003", name: "Glamour Me Rex Shirt", category: "Ladies", unitPrice: 99.99, image: "5135.jpg"),
    ProductModel(itemCode: "I004", name: "Clans Jean S4", category: "Ladies", unitPrice: 299.99, image: "5107.jpg"),
    ProductModel(itemCode: "I005", name: "Flamiyo Shoes", category: "Kids", unitPrice: 39.99, image: "5732_1.jpg"),
]
