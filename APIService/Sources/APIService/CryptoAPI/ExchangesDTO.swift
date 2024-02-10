//
//  File.swift
//  
//
//  Created by Berkay Sancar on 10.02.2024.
//

import Foundation

// MARK: - ExchangesDTOElement
public struct ExchangesDTOElement: Codable {
    public let id, name: String
    public let yearEstablished: Int?
    public let country, description: String?
    public let url: String
    public let image: String
    public let hasTradingIncentive: Bool?
    public let trustScore, trustScoreRank: Int
    public let tradeVolume24HBtc, tradeVolume24HBtcNormalized: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case yearEstablished = "year_established"
        case country, description, url, image
        case hasTradingIncentive = "has_trading_incentive"
        case trustScore = "trust_score"
        case trustScoreRank = "trust_score_rank"
        case tradeVolume24HBtc = "trade_volume_24h_btc"
        case tradeVolume24HBtcNormalized = "trade_volume_24h_btc_normalized"
    }
}

public typealias ExchangesDTO = [ExchangesDTOElement]
