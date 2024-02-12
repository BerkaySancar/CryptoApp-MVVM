//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public struct CoinDTO: Codable {
    public let id, symbol, name: String
    public let image: String
    public let currentPrice: Double
    public let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Int
    public let high24H, low24H, priceChange24H, priceChangePercentage24H: Double
    public let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply, totalSupply: Double
    public let maxSupply: Int?
    public let ath, athChangePercentage: Double
    public let athDate: String
    public let atl, atlChangePercentage: Double
    public let atlDate: String
    public let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
    }
}
