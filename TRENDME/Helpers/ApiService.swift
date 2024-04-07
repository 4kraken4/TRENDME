//
//  ApiService.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation

class APIService : ObservableObject {
    static let shared = APIService() // Singleton Instance
    
    private let baseURL = AppConfig.baseUrl
    
    func deleteData<T: Codable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
      guard let token = UserDefaults.standard.string(forKey: "token"),
          let url = URL(string: baseURL + endpoint) else {
          completion(.failure(ServerError.syntaxError))
        return
      }

      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "DELETE"
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

      performRequest(request: urlRequest, completion: completion)
    }
    
    func postData<T: Encodable, U: Decodable>(endpoint: String, body: T, completion: @escaping (Result<U, Error>) -> Void) {
        
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let url = URL(string: baseURL + endpoint) else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let data = try JSONEncoder().encode(body)
            urlRequest.httpBody = data
        } catch {
            completion(.failure(ServerError.decodingError(message: "Error encoding data")))
            return
        }
        
        performRequest(request: urlRequest, completion: completion)
    }
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let url = URL(string: baseURL + endpoint) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        performRequest(request: urlRequest, completion: completion)
    }
    
    func putData<T: Encodable, U: Decodable>(endpoint: String, body: T, completion: @escaping (Result<U, Error>) -> Void) {
      guard let token = UserDefaults.standard.string(forKey: "token"),
          let url = URL(string: baseURL + endpoint) else {
        return
      }
      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "PUT"
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

      do {
        let data = try JSONEncoder().encode(body)
        urlRequest.httpBody = data
      } catch {
        completion(.failure(ServerError.decodingError(message: "Error encoding data")))
        return
      }

      performRequest(request: urlRequest, completion: completion)
    }
    
    private func performRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(ServerError.connectionError(error: error as! URLError)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ServerError.dataError(message: "Invalid response received")))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(ServerError.dataError(message: "No data received")))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...209:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(ServerError.decodingError(message: "Error decoding data")))
                }
            default:
                if let errorResponse = try? JSONDecoder().decode(ErrorCodeResponse.self, from: data) {
                    let errorCode = errorResponse.errorCode
                    let errorMessage = errorResponse.errorMessage
                    completion(.failure(ServerError.custom(errorMessage: errorMessage, errorCode: errorCode)))
                } else {
                    // Attempt to parse error data for a more specific message (if possible)
                    var errorMessage = "Server error"
                    if let dataString = String(data: data, encoding: .utf8) {
                        errorMessage = dataString
                    }
                    completion(.failure(ServerError.custom(errorMessage: errorMessage, errorCode: nil)))
                }
            }
        }.resume()
    }
    
    
}



