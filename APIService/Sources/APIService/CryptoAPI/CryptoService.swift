//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public protocol CryptoServiceProtocol: AnyObject {
    func getCoins(currency: String, perPage: Int, page: Int, completion: @escaping (Result<[CoinDTO]?, ServiceError>) -> Void) async
    func getSearchTrendings(completion: @escaping (Result<[TrendDTO]?, ServiceError>) -> Void) async
    func getSearchedCoins(query: String, completion: @escaping (Result<[ItemDTO]?, ServiceError>) -> Void) async
}

public final class CryptoService: CryptoServiceProtocol {
    
    public init() {}
    
    public func getCoins(currency: String, perPage: Int, page: Int, completion: @escaping (Result<[CoinDTO]?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(CryptoAPI.getCoins(currency: currency, perPage: perPage, page: page), type: [CoinDTO].self) { results in
            
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
}
