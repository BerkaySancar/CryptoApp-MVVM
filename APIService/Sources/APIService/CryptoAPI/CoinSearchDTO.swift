//
//  File.swift
//  
//
//  Created by Berkay Sancar on 6.02.2024.
//

import Foundation

public struct SearchTrendDTO: Codable {
    public let coins: [TrendDTO]
}

public struct SearchDTO: Codable {
    public let coins: [ItemDTO]
}

public struct TrendDTO: Codable {
    public let item: ItemDTO
}

public struct ItemDTO: Codable {
    public let id, name, thumb, large: String
    public let marketCapRank: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case thumb, large
        case marketCapRank = "market_cap_rank"
    }
}
