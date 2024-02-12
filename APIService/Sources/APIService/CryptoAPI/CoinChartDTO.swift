//
//  File.swift
//  
//
//  Created by Berkay Sancar on 7.02.2024.
//

import Foundation

public struct MarketChartDTO: Codable {
    public let prices, marketCaps, totalVolumes: [[Double]]

    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps = "market_caps"
        case totalVolumes = "total_volumes"
    }
}
