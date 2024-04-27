//
//  UserModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-25.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let id: String
    let userID: Int
    let email, passwordHash, role, createdAt: String
    let updatedAt: String
    let v: Int
    let username: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "id"
        case email, passwordHash, role, createdAt, updatedAt
        case v = "__v"
        case username
    }
}
