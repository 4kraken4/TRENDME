//
//  Error.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-31.
//

import Foundation

struct ErrorMessageResponse: Codable {
    let errorMessage: String
}

struct ErrorCodeResponse: Codable {
    let errorCode: Int?
    let errorMessage: String
}
