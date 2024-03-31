//
//  CollectionViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-30.
//

import Foundation

class CollectionViewModel : ObservableObject {
    @Published var itemCollections: Items = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var collectionName: String = "All"
    private let apiService = APIService.shared
    
    func fetchCollection(category: String) {
        isLoading = true
        error = nil
        
        apiService.fetchData(endpoint: "/item/category/\(category.localizedLowercase.trimmingCharacters(in: .whitespacesAndNewlines))") { (result: Result<Items, Error>) in
            print(result)
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.itemCollections = data
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func fetchCollection() {
        self.fetchCollection(category: "")
    }
}
