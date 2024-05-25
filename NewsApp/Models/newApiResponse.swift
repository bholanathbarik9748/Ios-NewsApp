//
//  newApiResponse.swift
//  NewsApp
//
//  Created by Bholanath Barik on 05/05/24.
//

import Foundation

struct NewsApiResponse : Decodable {
    let status : String
    let totalResult: Int?
    let articles : [Article]?
    let statusCode : String?
    let message : String?
}
