//
//  CoinDetailViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 7.02.2024.
//

import APIService
import Foundation
    
final class CoinDetailViewModel: ObservableObject {
    
    private let cryptoService: CryptoServiceProtocol?
    private weak var coorinator: AppCoordinator?
    private let dispatchGroup = DispatchGroup()
    
    @Published var coin: CoinModel?
    private(set) var coinDetailModel: CoinDetailModel?
    private var coinId: String?
    
    @Published var prices: [Price] = []
    @Published var coinDetailDescription = ""
    @Published var homepage = ""
    private var serviceError = ""
    
    init(coordinator: AppCoordinator?, cryptoService: CryptoServiceProtocol?, coinId: String?) {
        self.cryptoService = cryptoService
        self.coorinator = coordinator
        self.coinId = coinId
        
        Task {
            await getData()
        }
    }
        
    var name: String? {
        return coin?.name
    }
    
    var symbol: String? {
        return coin?.symbol
    }
    
    var coinImage: String {
        return coin?.image ?? ""
    }
    
    var priceChangeCPercentage24h: String? {
        if let priceChange = coin?.priceChangeCPercentage24h {
            return "%" + String(format: "%.3f", priceChange)
        }
        return ""
    }
    
    var currentPrice: Double? {
        coin?.currentPrice
    }
    
    var average24h: Double? {
        if let high24h = coin?.high24h,
           let low24h = coin?.low24h {
            return Double(String(format: "%.4f", high24h - low24h)) ?? 0
        } else {
            return nil
        }
    }
    
    var high24h: Double? {
        return coin?.high24h
    }
    
    var low24h: Double? {
        return coin?.low24h
    }
    
    var ath: String? {
        return String(format: "%.3f", coin?.ath ?? "")
    }
    
    var athDate: String? {
        return coin?.athDate?.convertDateFormat
    }
    
    var atl: String? {
        return String(format: "%.3f", coin?.atl ?? "")
    }
    
    var atlDate: String? {
        return coin?.atlDate?.convertDateFormat
    }
    
    var isPriceChangePositive: Bool {
        if let priceChange = coin?.priceChangeCPercentage24h {
            return priceChange > 0 ? true : false
        }
        return false
    }
    
    private func getData() async {
        if let coinId {
            ActivityIndicatorManager.shared.startActivity()
            
            //MARK: Chart Prices
            dispatchGroup.enter()
            await cryptoService?.getMarketChartPrices(coinId: coinId, currency: "usd") { [weak self] results in
                guard let self else { return }
                dispatchGroup.leave()
                switch results {
                case .success(let data):
                    DispatchQueue.main.async {
                        if let data {
                            for item in data.prices {
                                let price = Price(unixTime: item[0], price: item[1])
                                self.prices.append(price)
                            }
                        }
                    }
                case .failure(let error):
                    serviceError.append("\n Chart data not loaded. " + error.errorDescription)
                }
            }
            
            //MARK: Coin Informations
            dispatchGroup.enter()
            await cryptoService?.getCoinDetail(coinId: coinId) { [weak self] results in
                guard let self else { return }
                dispatchGroup.leave()
                
                switch results {
                case .success(let data):
                    DispatchQueue.main.async {
                        if let data {
                            let detail = CoinDetailModel(description: data.description.en)
                            self.coinDetailModel = detail
                            self.coinDetailDescription = data.description.en
                            self.homepage = data.links.homepage.first ?? ""
                        }
                    }
                case .failure(let error):
                    serviceError.append("\n Coin informations not loaded. " + error.errorDescription)
                }
            }
            
            //MARK: Coin Detail
            dispatchGroup.enter()
            await cryptoService?.getCoins(coinId: coinId, currency: "usd", perPage: 1, page: 1) { [weak self] results in
                guard let self else { return }
                dispatchGroup.leave()
                switch results {
                case .success(let data):
                    DispatchQueue.main.async {
                        if let coin = data?.first {
                            self.coin = CoinModel(
                                id: coin.id,
                                name: coin.name,
                                image: coin.image,
                                currentPrice: coin.currentPrice,
                                priceChangeCPercentage24h: coin.priceChangePercentage24H,
                                symbol: coin.symbol,
                                high24h: coin.high24H,
                                low24h: coin.low24H,
                                priceChange24h: coin.priceChange24H,
                                ath: coin.ath,
                                atl: coin.atl,
                                athDate: coin.athDate,
                                atlDate: coin.atlDate
                            )
                        }
                    }
                case .failure(let error):
                    serviceError.append("\n Coin detail not loaded. " + error.errorDescription)
                }
            }
            
            // MARK: Notify
            dispatchGroup.notify(queue: .main) { [weak self] in
                guard let self else { return }
                ActivityIndicatorManager.shared.endActivity()
                
                if self.serviceError != "" {
                    AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Error", message: serviceError))
                }
            }
        }
    }
  
    func homepageTapped() {
        self.coorinator?.safari(urlString: homepage)
    }
}
