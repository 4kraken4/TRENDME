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
    
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return
        }
        
        let url = URL(string: baseURL + endpoint)!
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
