//
//  Article.swift
//  NewsApp
//
//  Created by Bholanath Barik on 04/05/24.
//

import Foundation

struct Article: Codable, Equatable, Identifiable  {
    var id : String { url }
    let source : Source
    let title : String
    let url : String
    let content : String
    let publishedAt : Date
    
    let author : String?
    let description : String?
    let urlToImage : String?
    
    var authorText : String {
        author ?? ""
    }
    
    var descriptionText : String {
        description ?? ""
    }
    
    var urlToImageText : String {
        urlToImage ?? ""
    }
    
    var articleURL : URL {
        URL(string : url)!
    }
    
    var captionText: String {
        "\(source.name) · \(RelativeDateTimeFormatter().localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage);
    }
}

extension Article {
    static var previewData : [Article] {
        let previeDataUrl = Bundle.main.url(forResource: "news", withExtension: "json")!;
        let data = try! Data(contentsOf: previeDataUrl);
        let jsonDecoder = JSONDecoder();
        jsonDecoder.dateDecodingStrategy = .iso8601;
        let apiResponse = try! jsonDecoder.decode(NewsApiResponse.self, from: data);
        return apiResponse.articles ?? [];
    }
}

struct Source : Codable, Equatable {
    let name : String
}

