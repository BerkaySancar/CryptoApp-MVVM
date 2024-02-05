//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public struct NewsDTO: Codable {
    public let status: String
    public let totalResults: Int
    public let articles: [ArticleDTO]
}

public struct ArticleDTO: Codable {
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
}
