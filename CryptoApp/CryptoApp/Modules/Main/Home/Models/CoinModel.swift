//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

struct CoinModel: Codable {
    let id: String?
    let name: String?
    let image: String?
    let currentPrice: Double?
    let priceChangeCPercentage24h: Double?
    let symbol: String?
    let high24h: Double?
    let low24h: Double?
    let priceChange24h: Double?
    let ath, atl: Double?
    let athDate, atlDate: String?
}
