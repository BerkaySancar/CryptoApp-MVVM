//
//  TopCoinsCellVM.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

final class TopCoinsCellVM: BaseCellVM {
    
    private var coins: [CoinModel]?
    
    init(coins: [CoinModel]?) {
        self.coins = coins
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        self.coins?.prefix(8).count ?? 0
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        .init(width: 160, height: 170)
    }
    
    func getCellVM(indexPath: IndexPath) -> BaseCellVM {
        return TopCoinCellVM(coin: self.coins?.prefix(8)[indexPath.item])
    }
}
