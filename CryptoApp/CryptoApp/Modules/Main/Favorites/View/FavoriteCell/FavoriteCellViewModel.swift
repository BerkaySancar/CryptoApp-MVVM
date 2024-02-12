//
//  FavoriteCellViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import Foundation

final class FavoriteCellViewModel: BaseCellViewModel {
    
    private var favCoin: FavoriteCoinModel?
    
    init(favCoin: FavoriteCoinModel?) {
        self.favCoin = favCoin
    }
    
    var name: String? {
        return favCoin?.name ?? ""
    }
    
    var image: String? {
        return favCoin?.image ?? ""
    }
    
    var symbol: String? {
        return "(\(favCoin?.symbol ?? ""))"
    }
}
