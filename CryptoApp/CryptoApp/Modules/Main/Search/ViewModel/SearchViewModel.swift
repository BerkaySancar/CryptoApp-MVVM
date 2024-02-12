//
//  SearchViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation
import APIService

//MARK: View Model Outputs
protocol SearchViewModelOutputs: AnyObject {
    func setNavTitle(title: String)
    func dataRefreshed()
    func didChangeTrendLabelVisibility(_ isHidden: Bool)
    func prepareEmptyContentView()
}

//MARK: View Model Responsibilities
protocol SearchViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel
    func numberOfRowsInSection(section: Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func didSelectItemAt(indexPath: IndexPath)
    func searchTextDidChange(text: String)
}

//MARK: ViewModel
final class SearchViewModel {
    private weak var view: SearchViewModelOutputs?
    private weak var coordinator: AppCoordinator?
    private let cryptoService: CryptoServiceProtocol?
    
    private var coins: [SearchCoinModel]?
    private var seachTrendCoins: [SearchCoinModel]?
    
    private var searchTimer: Timer?
    
    init(view: SearchViewModelOutputs, coordinator: AppCoordinator, cryptoService: CryptoServiceProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.cryptoService = cryptoService
    }
    
    private func getSearchTrendings() async {
        ActivityIndicatorManager.shared.startActivity()
        await cryptoService?.getSearchTrendings { [weak self] results in
            guard let self else { return }
            ActivityIndicatorManager.shared.endActivity()
            switch results {
            case .success(let data):
                if let data {
                    self.coins = data.map {
                        SearchCoinModel(
                            id: $0.item.id,
                            name: $0.item.name,
                            thumb: $0.item.thumb,
                            large: $0.item.large,
                            marketCapRank: $0.item.marketCapRank
                        )
                    }
                    self.seachTrendCoins = self.coins
                    DispatchQueue.main.async {
                        self.view?.dataRefreshed()
                    }
                }
            case .failure(let error):
                AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Search trendings are not loaded.",
                                                                         message: error.errorDescription))
            }
        }
    }
}

//MARK: ViewModel Protocol
extension SearchViewModel: SearchViewModelProtocol {
    
    func viewDidLoad() {
        Task {
            await getSearchTrendings()
        }
        view?.prepareEmptyContentView()
    }
    
    func viewWillAppear() {
        view?.setNavTitle(title: "Search")
    }
    
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel {
        return SearchCoinCellVM(model: self.coins?[indexPath.row])
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.coins?.count ?? 0
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let selectedCoinId = self.coins?[indexPath.row].id
        self.coordinator?.coinDetail(coinId: selectedCoinId)
    }
    
    func searchTextDidChange(text: String) {
        if text.count > 2 {
            searchTimer?.invalidate()
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                guard let self else { return }
                self.view?.didChangeTrendLabelVisibility(true)
                Task {
                    await self.cryptoService?.getSearchedCoins(query: text) { results in
                        switch results {
                        case .success(let data):
                            if let data {
                                self.coins = data.map {
                                    SearchCoinModel(
                                        id: $0.id,
                                        name: $0.name,
                                        thumb: $0.thumb,
                                        large: $0.large,
                                        marketCapRank: $0.marketCapRank
                                    )
                                }
                                DispatchQueue.main.async {
                                    self.view?.dataRefreshed()
                                }
                            }
                        case .failure(let error):
                            AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Searched coins is not loaded.",
                                                                                     message: error.errorDescription))
                        }
                    }
                }
            }
        } else {
            self.coins = self.seachTrendCoins
            self.view?.dataRefreshed()
            self.view?.didChangeTrendLabelVisibility(false)
        }
    }
}
