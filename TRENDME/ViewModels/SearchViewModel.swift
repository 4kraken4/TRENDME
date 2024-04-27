//
//  SearchViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-04-06.
//

import Foundation

class SearchViewModel : ObservableObject {
    @Published var searchString: String = ""
    @Published var success : Bool = false
    @Published var isError : Bool = false
    @Published var error: Error?
    @Published var errorMessage : String = ""
    @Published var result : Items = []
    @Published var isLoading: Bool = false
    private let apiService = APIService.shared
    @Published var applyFilters: Bool = false
    @Published var selectedBrands: [String] = []
    @Published var selectedCategories: [String] = []
    @Published var selectedLowerPrice: Int = 0
    @Published var selectedUpperPrice: Int = 0
    
    func search(category: String) {
        isLoading = true
        self.isError = false
        apiService.fetchData(endpoint: "/item/search/category/\(category)/query/\(self.searchString)") { (result: Result<Items, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.result.removeAll()
                    self.result = data
                case .failure(let error):
                    self.isError = true
                    self.error = error
                }
            }
        }
    }
    
    func searchWithFilters(category: String) {
        isLoading = true
        self.isError = false
        let endpoint = "/item/search?q=\(self.searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&price_min=\(selectedLowerPrice)&price_max=\(selectedUpperPrice)&category=\(category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
        apiService.fetchData(endpoint: endpoint) { (result: Result<Items, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.result.removeAll()
                    self.result = data
                case .failure(let error):
                    self.isError = true
                    self.error = error
                }
            }
        }
    }
    
    func clearResult() {
        self.result.removeAll()
    }
    
}
