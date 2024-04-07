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
    
    func search(category: String) {
        isLoading = true
        self.isError = false
        apiService.fetchData(endpoint: "/item/search/category/\(category)/query/\(self.searchString)") { (result: Result<Items, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
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
