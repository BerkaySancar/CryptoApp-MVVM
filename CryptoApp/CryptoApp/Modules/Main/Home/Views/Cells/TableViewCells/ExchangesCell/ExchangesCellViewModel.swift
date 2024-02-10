//
//  ExchangesCellViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 10.02.2024.
//

import Foundation
import UIKit.UIColor

final class ExchangesCellViewModel: BaseCellViewModel {
    
    private var exchanges: [ExchangeModel]?
    
    private var colors: [UIColor] {
        var colors: [UIColor] = []
        for _ in 0...(exchanges?.count ?? 0) {
            colors.append(.generateRandomCellColor())
        }
        return colors
    }
    
    init(exchanges: [ExchangeModel]?) {
        self.exchanges = exchanges
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return exchanges?.prefix(10).count ?? 0
    }
    
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel {
        return ExchangeCellVM(exhance: self.exchanges?.prefix(10)[indexPath.item], color: self.colors[indexPath.item])
    }
    
}
