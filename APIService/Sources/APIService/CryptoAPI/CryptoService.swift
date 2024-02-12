//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public protocol CryptoServiceProtocol: AnyObject {
    func getCoins(coinId: String?, currency: String, perPage: Int, page: Int, completion: @escaping (Result<[CoinDTO]?, ServiceError>) -> Void) async
    func getSearchTrendings(completion: @escaping (Result<[TrendDTO]?, ServiceError>) -> Void) async
    func getSearchedCoins(query: String, completion: @escaping (Result<[ItemDTO]?, ServiceError>) -> Void) async
    func getMarketChartPrices(coinId: String, currency: String, completion: @escaping (Result<MarketChartDTO?, ServiceError>) -> Void) async
    func getCoinDetail(coinId: String, completion: @escaping (Result<CoinDetailDTO?, ServiceError>) -> Void) async
    func getExchanges(completion: @escaping (Result<ExchangesDTO?, ServiceError>) -> Void) async
}

public final class CryptoService: CryptoServiceProtocol {
    
    public init() {}
    
    public func getCoins(coinId: String?,
                         currency: String,
                         perPage: Int,
                         page: Int,
                         completion: @escaping (Result<[CoinDTO]?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.getCoins(coinId: coinId, currency: currency, perPage: perPage, page: page), type: [CoinDTO].self) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func getSearchTrendings(completion: @escaping (Result<[TrendDTO]?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.searchTrendings, type: SearchTrendDTO.self) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data?.coins))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getSearchedCoins(query: String, completion: @escaping (Result<[ItemDTO]?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.searchCoin(query: query), type: SearchDTO.self) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data?.coins))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getMarketChartPrices(coinId: String,
                                     currency: String,
                                     completion: @escaping (Result<MarketChartDTO?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.getMarketChartPrices(coinId: coinId,
                                                                           currency: currency),
                                            type: MarketChartDTO.self) { results  in
            
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    public func getCoinDetail(coinId: String, completion: @escaping (Result<CoinDetailDTO?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.getCoinDetail(coinId: coinId), type: CoinDetailDTO.self) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getExchanges(completion: @escaping (Result<ExchangesDTO?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.getExchanges, type: ExchangesDTO.self) { results in
            
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
