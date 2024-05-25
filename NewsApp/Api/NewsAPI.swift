//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Bholanath Barik on 19/05/24.
//

import Foundation

// Define the NewsAPI struct
struct NewsAPI {
    // Create a single shared instance of NewsAPI (singleton)
    static let shared = NewsAPI()
    
    // Private initializer to prevent creating additional instances
    private init () {}
    
    // API key for accessing the News API
    private let apiKey = "8a732067bbcc42b1815fe5311fec09d6"
    
    // Shared URL session for making network requests
    private let session = URLSession.shared // Global level API shared handler

    // JSON decoder configured to decode ISO 8601 date strings
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Set date decoding strategy to ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
        return decoder
    }()
    
    // Error Message Handler function
    private func generateError(code: Int = 1, description: String) -> Error {
        // Create an NSError object with the provided error code, domain, and description
        return NSError(domain: "NewsApi", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    // Fetches news articles asynchronously from a specific category.
    func fetch(from category: Category) async throws -> [Article] {
        // Generate a URL for fetching news articles from the specified category.
        let newsURL = generateNewsURL(from: category)
        
        // Call the fetchArticles function to perform the network request and retrieve the articles.
        // Use the 'try await' keyword to handle asynchronous operations that may throw errors.
        return try await fetchArticles(from: newsURL)
    }

    // Searches for news articles asynchronously based on a query string.
    func search(for query: String) async throws -> [Article] {
        // Generate a URL for searching news articles using the provided query string.
        let searchURL = generateSearchURL(form: query)
        
        // Call the fetchArticles function to perform the network request and retrieve the articles.
        // Use the 'try await' keyword to handle asynchronous operations that may throw errors.
        return try await fetchArticles(from: searchURL)
    }

    
    // This function retrieves articles from a given URL asynchronously and throws errors if any occur.
    private func fetchArticles(from url: URL) async throws -> [Article] {
        // Perform an asynchronous data task to fetch data from the provided URL
        let (data, response) = try await session.data(from: url)
        
        // Check if the response is an HTTPURLResponse
        guard let response = response as? HTTPURLResponse else {
            // If not, generate an error for a bad response
            throw generateError(description: "Bad Response")
        }
        
        // Check the status code of the HTTP response
        switch response.statusCode {
            // If the status code is in the range 200...299 or 400...499
            case (200...299), (400...499):
                // Decode the received data into a NewsApiResponse object
                let apiResponse = try jsonDecoder.decode(NewsApiResponse.self, from: data)
                // Check if the status of the API response is "ok"
                if apiResponse.status == "ok" {
                    // If yes, return the articles from the API response, or an empty array if articles are nil
                    return apiResponse.articles ?? []
                } else {
                    // If the status is not "ok", generate an error indicating a server error occurred
                    throw generateError(description: "A server error occurred")
                }
            
            // If the status code is not in the expected range
            default:
                // Generate an error indicating a server error occurred
                throw generateError(description: "A server error occurred")
        }
    }

    // This function generates a URL for searching news articles based on a query string.
    private func generateSearchURL(form query : String) -> URL {
        // Encode the query string to make sure it's safe for use in a URL.
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query;
        
        // Start building the URL string with the base URL for the News API search endpoint.
        var url = "https://newsapi.org/v2/everything?"
        
        // Append the API key parameter to the URL string.
        url += "apiKey=\(apiKey)"
        
        // Append the language parameter to the URL string (English in this case).
        url += "&language=en"
        
        // Append the encoded query string as the search query parameter to the URL string.
        url += "&q=\(percentEncodedString)"
        
        // Construct a URL object from the completed URL string and return it.
        return URL(string : url)!;
    }
    
    // This function generates a URL for fetching top headlines from a specific category.
    private func generateNewsURL(from category: Category) -> URL {
        // Start building the URL string with the base URL for the News API top headlines endpoint.
        var url = "https://newsapi.org/v2/top-headlines?"
        
        // Append the API key parameter to the URL string.
        url += "apiKey=\(apiKey)"
        
        // Append the language parameter to the URL string (English in this case).
        url += "&language=en"
        
        // Append the category parameter to the URL string, using the raw value of the Category enum.
        // This represents the specific category of news articles to fetch.
        url += "&category=\(category.rawValue)"
        
        // Construct a URL object from the completed URL string and return it.
        // Force unwrap the URL object because we're assuming the URL string is valid.
        return URL(string: url)!
    }
}
