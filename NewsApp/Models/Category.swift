//
//  Category.swift
//  NewsApp
//
//  Created by Bholanath Barik on 19/05/24.
//

import Foundation

enum Category : String, CaseIterable, Identifiable {
        var id: Self { self }
        case general
        case business
        case technology
        case entertainment
        case sports
        case science
        case health
        
        var text: String {
            if self == .general {
                return "Top Headlines"
            }
            return rawValue.capitalized
        }
}
