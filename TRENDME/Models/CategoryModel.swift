//
//  CategoryModel.swift
//  TRENDME
//
//  Created by Mangi Wimalaweera on 2024-03-27.
//

import Foundation

struct CategoryModel : Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}

var categoryList : [CategoryModel] = [
    CategoryModel(icon: "", title: "All"),
    CategoryModel(icon: "", title: "Mens"),
    CategoryModel(icon: "", title: "Ladies"),
    CategoryModel(icon: "", title: "Kids")
]
