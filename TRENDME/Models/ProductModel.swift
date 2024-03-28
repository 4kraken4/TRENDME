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
    ProductModel(itemCode: "I001", name: "Cool Summer Shirt", category: "Men", unitPrice: 59.99, image: "MIG001"),
    ProductModel(itemCode: "I002", name: "Cool Summer Pant", category: "Men", unitPrice: 109.99, image: "MIG001"),
    ProductModel(itemCode: "I003", name: "Glamour Me Rex Shirt", category: "Wen", unitPrice: 99.99, image: "MIG001"),
    ProductModel(itemCode: "I004", name: "Clans Jean S4", category: "Wen", unitPrice: 299.99, image: "MIG001"),
    ProductModel(itemCode: "I005", name: "Flamiyo Shoes", category: "Kid", unitPrice: 39.99, image: "MIG001"),
]
