//
//  ItemViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-30.
//

import Foundation

class ItemViewModel : ObservableObject {
    @Published var items: Items?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private let apiService = APIService.shared
    
    func fetchCollection(category: String) {
        isLoading = true
        error = nil
        
        apiService.fetchData(endpoint: "/item/category/$\(category.localizedLowercase.trimmingCharacters(in: .whitespacesAndNewlines))") { (result: Result<Items, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.items = data
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func fetchCollections() {
        isLoading = true
        error = nil
        
        apiService.fetchData(endpoint: "/item/category") { (result: Result<Items, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    print(data)
                    self.items = data
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
