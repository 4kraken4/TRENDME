//
//  HomeViewModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-29.
//

import Foundation


class HomeViewModel : ObservableObject {
    @Published var itemCollections: CategorialTagItemCollections = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    private let apiService = APIService.shared
    
    func fetchCollection(category: String) {
        isLoading = true
        error = nil
        
        apiService.fetchData(endpoint: "/item/category/\(category.localizedLowercase.trimmingCharacters(in: .whitespacesAndNewlines))") { (result: Result<CategorialTagItemCollections, Error>) in
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
    
    func fetchTrendingCollections() {
        isLoading = true
        error = nil
        
        apiService.fetchData(endpoint: "/item/category/tag/trending") { (result: Result<CategorialTagItemCollections, Error>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.itemCollections = data
                case .failure(let error):
                    self.error = error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getItems(id: String) -> Items {
        var items: Items = Items()
        for collection in self.itemCollections {
            for item in collection.items {
                if collection.id == id {
                    let i = Item(id: "", itemID: item.id, name: item.name, image: item.image, unitPrice: item.unitPrice, description: item.description, tags: [item.tags], category: Category(rawValue: "men") ?? Category.non)
                    items.append(i)
                }
            }
        }
        return items
    }
}
