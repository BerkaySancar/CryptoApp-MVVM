//
//  ExchangeCellViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 10.02.2024.
//

import Foundation
import UIKit.UIColor

final class ExchangeCellVM: BaseCellViewModel {
    
    private var exhance: ExchangeModel?
    
    init(exhance: ExchangeModel?, color: UIColor) {
        self.exhance = exhance
        self.bgColor = color
    }
    
    private(set) var bgColor: UIColor?
    
    var name: String? {
        return exhance?.name
    }
    
    var country: String? {
        return exhance?.country
    }
    
    var rank: String? {
        return "Rank " + String(exhance?.trustScoreRank ?? 0)
    }
    
    var establishedYear: String? {
        return String(exhance?.yearEstablished ?? 0) + ","
    }
    
    var image: String? {
        return exhance?.image
    }
    
    var tradeVolume: String? {
        return "Trade Volume (24h): \(String(format: "%.2f", exhance?.tradeVolume ?? 0)) BTC"
    }
    
    var description: String? {
        return exhance?.description
    }
}
