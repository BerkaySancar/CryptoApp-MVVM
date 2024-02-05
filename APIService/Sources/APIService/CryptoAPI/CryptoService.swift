//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public protocol CryptoServiceProtocol: AnyObject {
    func getCoins(currency: String, perPage: Int, page: Int, completion: @escaping (Result<[CoinDTO]?, ServiceError>) -> Void) async
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
}
