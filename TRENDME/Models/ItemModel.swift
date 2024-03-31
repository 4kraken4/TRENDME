// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let itemCollections = try? JSONDecoder().decode(ItemCollections.self, from: jsonData)

import Foundation

// MARK: - CategoryItemCollection
struct CategoryItemCollection: Codable, Hashable, Identifiable{
    var id: UUID = .init()
    let category: Category
    let items: [Item]
}

// MARK: - TagItemCollections
struct TagItemCollection: Codable, Hashable {    
    let tag: String
    let items: [Item]
}

// MARK: - CategorialTagItemCollection
struct CategorialTagItemCollection: Codable, Hashable, Identifiable {
    let id: String
    let items: [CategorialTagItem]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case items
    }
}

enum Category: String, Codable {
    case men = "men"
    case wemen = "women"
    case kids = "kids"
    case all = "All"
    case non = ""
}

// MARK: - Item
struct Item: Codable, Hashable, Identifiable{
    let id: String
    let itemID: Int
    let name: String
    let image: String
    let unitPrice: Double
    let description: String
    let tags: [String]
    let category: Category
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case itemID = "id"
        case name, image, unitPrice, description, tags, category
    }
    
    func toCategorialTagItem() -> CategorialTagItem {
            return CategorialTagItem(id: self.itemID,
                                      name: self.name,
                                      image: self.image,
                                      unitPrice: self.unitPrice,
                                      description: self.description,
                                      tags: self.tags.joined(separator: ", "))
        }
}

struct CategorialTagItem: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let unitPrice: Double
    let description: String
    let tags: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name, image, unitPrice, description, tags
    }
    
    func toItem() -> Item {
            return Item(id: UUID().uuidString,
                        itemID: self.id,
                        name: self.name,
                        image: self.image,
                        unitPrice: self.unitPrice,
                        description: self.description,
                        tags: self.tags.components(separatedBy: ", "),
                        category: Category.non
                        )
        }
}


typealias CategoryItemCollections = [CategoryItemCollection]
typealias CategorialTagItemCollections = [CategorialTagItemCollection]
typealias TagItemCollections = [TagItemCollection]
typealias CategorialTagItems = [CategorialTagItem]
typealias Items = [Item]

