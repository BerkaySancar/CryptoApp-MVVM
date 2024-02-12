//
//  SearchCoinCellVM.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 6.02.2024.
//

import Foundation

final class SearchCoinCellVM: BaseCellViewModel {
    
    private var model: SearchCoinModel?
    
    init(model: SearchCoinModel?) {
        self.model = model
    }
    
    var name: String? {
        model?.name
    }
    
    var rank: Int? {
        model?.marketCapRank
    }
    
    var largeImage: String? {
        model?.large
    }
}
