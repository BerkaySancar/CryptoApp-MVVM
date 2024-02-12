//
//  TopCoinViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

final class TopCoinCellVM: BaseCellViewModel {
    
    private var coin: CoinModel?
    
    init(coin: CoinModel?) {
        self.coin = coin
    }
    
    var name: String? {
        coin?.name
    }
    
    var currentPrice: Double? {
        coin?.currentPrice
    }
    
    var image: String? {
        coin?.image
    }
    
    var priceChangeCPercentage24h: Double? {
        coin?.priceChangeCPercentage24h
    }
}
