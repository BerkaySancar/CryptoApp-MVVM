//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import Foundation
import APIService

//MARK: ViewModel Outputs
protocol HomeViewModelOutputs: AnyObject {
    func setNavTitle(title: String)
    func dataRefreshed()
}

//MARK: ViewModel Resposibilities
protocol HomeViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection(section: Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel?
}

//MARK: Cell Types
enum HomeViewCellType: CaseIterable {
    case totalBalance
    case topCoins
    case news
    
    static func getType(index: Int) -> HomeViewCellType {
        return self.allCases[index]
    }
    
    static func numberOfTypes() -> Int {
        return self.allCases.count
    }
}

//MARK: View Model
final class HomeViewModel {
    private weak var coordinator: AppCoordinator?
    private weak var view: HomeViewModelOutputs?
    private let cryptoService: CryptoServiceProtocol?
    private let newsService: NewsServiceProtocol?
    private var dispatchGroup: DispatchGroup?
    
    private var coins: [CoinModel]?
    private var articles: [ArticleModel]?
    
    private var serviceErrorMessage: String?
    
    init(
        coordinator: AppCoordinator,
        view: HomeViewModelOutputs,
        cryptoService: CryptoServiceProtocol?,
        newsService: NewsServiceProtocol?,
        dispatchGroup: DispatchGroup = .init()
    ) {
        self.coordinator = coordinator
        self.view = view
        self.cryptoService = cryptoService
        self.newsService = newsService
        self.dispatchGroup = dispatchGroup
    }
    
    private func getData() async {
        ActivityIndicatorManager.shared.startActivity()
        self.serviceErrorMessage = ""
        
        self.dispatchGroup?.enter()
        await cryptoService?.getCoins(coinId: nil, currency: "usd", perPage: 10, page: 1) { [weak self] results in
            guard let self else { return }
            self.dispatchGroup?.leave()
            switch results {
            case .success(let data):
                if let data {
                    self.coins = data.map {
                        CoinModel(
                            id: $0.id,
                            name: $0.name,
                            image: $0.image,
                            currentPrice: $0.currentPrice,
                            priceChangeCPercentage24h: $0.priceChangePercentage24H,
                            symbol: $0.symbol,
                            high24h: $0.high24H,
                            low24h: $0.low24H,
                            priceChange24h: $0.priceChange24H,
                            ath: $0.ath,
                            atl: $0.atl,
                            athDate: $0.athDate,
                            atlDate: $0.atlDate
                        )
                    }
                }
            case .failure(let error):
                self.serviceErrorMessage = "\n\nCoins are not loaded. \n\(error.errorDescription)\n"
            }
        }
        
        self.dispatchGroup?.enter()
        await newsService?.getCryptoNews { [weak self] results in
            guard let self else { return }
            self.dispatchGroup?.leave()
            switch results {
            case .success(let data):
                if let data {
                    self.articles = data.map {
                        ArticleModel(
                            title: $0.title,
                            url: $0.url,
                            urlToImage: $0.urlToImage,
                            author: $0.author,
                            description: $0.description,
                            content: $0.content,
                            publishedAt: $0.publishedAt
                        )
                    }
                }
                break
            case .failure(let error):
                self.serviceErrorMessage?.append("\nNews are not loaded.\n \(error.errorDescription)\n")
            }
        }
        
        dispatchGroup?.notify(queue: .main) { [weak self] in
            guard let self else { return }
            ActivityIndicatorManager.shared.endActivity()
            
            if serviceErrorMessage != "" {
                AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Error", message: self.serviceErrorMessage ?? ""))
            }
            
            self.view?.dataRefreshed()
        }
    }
}

//MARK: ViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        Task {
            await getData()
        }
    }
    
    func viewWillAppear() {
        view?.setNavTitle(title: "Home")
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        HomeViewCellType.numberOfTypes()
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch HomeViewCellType.getType(index: indexPath.row) {
        case .totalBalance:
            240
        case .topCoins:
            240
        case .news:
            220
        }
    }
    
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel? {
        switch HomeViewCellType.getType(index: indexPath.row) {
        case .totalBalance:
            return nil
        case .topCoins:
            let viewModel = TopCoinsCellVM(coins: self.coins)
            viewModel.delegate = self
            return viewModel
        case .news:
            let viewModel = NewsCellViewModel(articles: self.articles)
            viewModel.delegate = self
            return viewModel
        }
    }
}

//MARK: - TopCoinsCell View Model Delegate
extension HomeViewModel: TopCoinsCellVMDelegate {
    
    func didSelectItem(coinId: String?) {
        if let coinId {
            self.coordinator?.coinDetail(coinId: coinId)
        }
    }
    
    func seeAllButtonTapped() {
        self.coordinator?.articleList(articles: self.articles)
    }
}

//MARK: - NewsCell View Model Delegate
extension HomeViewModel: NewsCellViewModelDelegate {
    
    func didSelectItem(item: ArticleModel?) {
        if let item {
            self.coordinator?.newsDetail(article: item)
        }
    }
}
