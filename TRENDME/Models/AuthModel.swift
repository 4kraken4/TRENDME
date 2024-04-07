//
//  AuthModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-31.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct SignUPRequest: Codable {
    let username: String
    let email: String
    let password: String
}

struct LoginResponse : Codable {
    let token: String
    let refreshToken: String
}
