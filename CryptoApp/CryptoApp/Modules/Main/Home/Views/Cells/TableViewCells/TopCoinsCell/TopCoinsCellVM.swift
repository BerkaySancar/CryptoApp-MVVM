//
//  TopCoinsCellVM.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

protocol TopCoinsCellVMDelegate: AnyObject {
    func didSelectItem(coinId: String?)
    func seeAllCoinsButtonTapped()
}

final class TopCoinsCellVM: BaseCellViewModel {
    
    weak var delegate: TopCoinsCellVMDelegate?
    private var coins: [CoinModel]?
    
    init(coins: [CoinModel]?) {
        self.coins = coins
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        self.coins?.prefix(5).count ?? 0
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        .init(width: 160, height: 190)
    }
    
    func getCellVM(indexPath: IndexPath) -> BaseCellViewModel {
        return TopCoinCellVM(coin: self.coins?.prefix(5)[indexPath.item])
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        self.delegate?.didSelectItem(coinId: self.coins?[indexPath.item].id)
    }
    
    func seeAllCoinsButtonTapped() {
        self.delegate?.seeAllCoinsButtonTapped()
    }
}
