//
//  WebService.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

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

class AuthService: ObservableObject {
    private let baseURL: String = AppConfig.baseUrl
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/auth/login") else {
            completion(.failure(.custom(errorMessage: "Incorrect URL")))
            return
        }
        
        let body = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = Optional(loginResponse.token)  else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
        }.resume()
    }
    
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://localhost:55255/loginurl") else {
            completion(.failure(.custom(errorMessage: "Incorrect URL")))
            return
        }
        
        let body = SignUPRequest(username: username, email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = Optional(loginResponse.token)  else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
        }.resume()
    }
}
