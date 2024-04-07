//
//  ErrorType.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-31.
//

import Foundation

enum ServerError : Error {
    case userExists
    case emptyCartError
    case privilegeMissingError
    case invalidEmailError
    case invalidPasswordError
    case invalidTokenError
    case tokenDoesNotExistError
    case authorizationHeaderMissingError
    case tokenRevokedError
    case badCredentialsError
    case userNotFoundError
    case userExistsError
    case syntaxError
    case serverError
    case connectionError(error: URLError)
    case dataError(message: String)
    case decodingError(message: String)
    case custom(errorMessage: String, errorCode: Int?)
}
