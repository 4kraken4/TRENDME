//
//  OrderModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-07.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let orderID, userID, cartID, total: Int
    let status, id, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case orderID = "id"
        case userID = "userId"
        case cartID = "cartId"
        case total, status
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}



struct OrderRequest: Codable {
    let userId, cartId: Int
    let total: Double
}
