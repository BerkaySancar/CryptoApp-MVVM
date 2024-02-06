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
    func dataRefreshed()
}

//MARK: ViewModel Resposibilities
protocol HomeViewModelProtocol {
    func viewDidLoad()
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
    
    init(coordinator: AppCoordinator, view: HomeViewModelOutputs, cryptoService: CryptoServiceProtocol?, newsService: NewsServiceProtocol?, dispatchGroup: DispatchGroup = .init()) {
        self.coordinator = coordinator
        self.view = view
        self.cryptoService = cryptoService
        self.newsService = newsService
        self.dispatchGroup = dispatchGroup
        Task {
            await getData()
        }
    }
    
    private func getData() async {
        ActivityIndicatorManager.shared.startActivity()
        self.serviceErrorMessage = ""
        
        self.dispatchGroup?.enter()
        await cryptoService?.getCoins(currency: "usd", perPage: 10, page: 1) { [weak self] results in
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
                            priceChangeCPercentage24h: $0.priceChangePercentage24H
                        )
                    }
                }
            case .failure(let error):
                self.serviceErrorMessage = "\nCoins are not loaded. \n\n\(error.localizedDescription)"
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
                            author: $0.author
                        )
                    }
                }
                break
            case .failure(let error):
                self.serviceErrorMessage?.append("\nNews are not loaded.\n\n \(error.localizedDescription)")
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
            return TopCoinsCellVM(coins: self.coins)
        case .news:
            return NewsCellViewModel(articles: self.articles)
        }
    }
}
