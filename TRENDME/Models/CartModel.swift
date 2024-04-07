//
//  CartModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-07.
//

import Foundation

struct CartModel : Codable {
    let id: Int?
    let items: Items
    let status: Bool
}

struct CartModelResponse: Codable {
    let cartModelID, userID: Int
    let items: [Item]
    let status, id, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case cartModelID = "id"
        case userID = "userId"
        case items, status
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
