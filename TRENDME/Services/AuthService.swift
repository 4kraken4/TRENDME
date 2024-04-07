//
//  WebService.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation

class AuthService: ObservableObject {
    private let baseURL: String = AppConfig.baseUrl
    func login(email: String, password: String, completion: @escaping (Result<String, ServerError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/auth/login") else {
            completion(.failure(.custom(errorMessage: "Incorrect URL", errorCode: nil)))
            return
        }
        
        let body = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data", errorCode: nil)))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.badCredentialsError))
                return
            }
            
            guard let token = Optional(loginResponse.token)  else {
                completion(.failure(.custom(errorMessage: error?.localizedDescription ?? "", errorCode: nil)))
                return
            }
            
            completion(.success(token))
        }.resume()
    }
    
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<String, ServerError>) -> Void)  {
        guard let url = URL(string: "\(baseURL)/auth/register") else {
            completion(.failure(.custom(errorMessage: "Incorrect URL", errorCode: nil)))
            return
        }
        
        let body = SignUPRequest(username: username, email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.custom(errorMessage: "No response", errorCode: nil)))
                    return
                }
                
                guard let data = data, error == nil else {
                    completion(.failure(.custom(errorMessage: "No data", errorCode: nil)))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data),
                          let token = Optional(loginResponse.token) else {
                        completion(.failure(.badCredentialsError))
                        return
                    }
                    completion(.success(token))
                default:
                    if let errorResponse = try? JSONDecoder().decode(ErrorCodeResponse.self, from: data) {
                        let errorCode = errorResponse.errorCode
                        let errorMessage = errorResponse.errorMessage
                        completion(.failure(.custom(errorMessage: errorMessage, errorCode: errorCode)))
                    } else {
                        completion(.failure(.custom(errorMessage: "Unknown server error", errorCode: nil)))
                    }
                }
            }.resume()
    }
}
