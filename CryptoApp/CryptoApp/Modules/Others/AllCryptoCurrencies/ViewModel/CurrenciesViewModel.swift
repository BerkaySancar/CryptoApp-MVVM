//
//  CurrenciesViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 9.02.2024.
//

import Foundation
import UIKit.UIScreen

protocol CurrenciesViewModelOutputs: AnyObject {
    func registerCell()
    func setNavTitle(title: String)
    func prepareBarButtonItem()
    func dataRefreshed()
}

protocol CurrenciesViewModelProtocol {
    func viewDidLoad()
    func numberOfItemsIn(section: Int) -> Int
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel
    func sortButtonTapped(_ type: CurrenciesSortType)
    func didSelectItemAt(indexPath: IndexPath)
}

enum CurrenciesSortType {
    case sortByName
    case sortByPrice
    case sortByPriceChange
}

final class CurrenciesViewModel: CurrenciesViewModelProtocol {
    private weak var coordinator: AppCoordinator?
    private weak var view: CurrenciesViewModelOutputs?
    
    private var coins: [CoinModel]?
    
    init(coordinator: AppCoordinator, view: CurrenciesViewModelOutputs, coins: [CoinModel]?) {
        self.coordinator = coordinator
        self.view = view
        self.coins = coins
    }
    
    func viewDidLoad() {
        view?.registerCell()
        view?.setNavTitle(title: "Crypto Currencies")
        view?.prepareBarButtonItem()
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return self.coins?.count ?? 0
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width / 3.5, height: 200)
    }
    
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel {
        return TopCoinCellVM(coin: self.coins?[indexPath.item])
    }
    
    func sortButtonTapped(_ type: CurrenciesSortType) {
        switch type {
        case .sortByPriceChange:
            self.coins?.sort { $0.priceChange24h ?? 0 > $1.priceChange24h ?? 0 }
        case .sortByName:
            self.coins?.sort { $0.name ?? "" < $1.name ?? "" }
        case .sortByPrice:
            self.coins?.sort { $0.currentPrice ?? 0 > $1.currentPrice ?? 0 }
        }
        view?.dataRefreshed()
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        self.coordinator?.coinDetail(coinId: self.coins?[indexPath.item].id)
    }
}
