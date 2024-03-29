//
//  ArticleModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

struct ArticleModel: Codable {
    let title: String?
    let url: String?
    let urlToImage: String?
    let author: String?
    let description: String?
    let content: String?
    let publishedAt: String?
}
