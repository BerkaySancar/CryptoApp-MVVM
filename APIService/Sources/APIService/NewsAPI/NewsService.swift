//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public protocol NewsServiceProtocol: AnyObject {
    func getCryptoNews(completion: @escaping (Result<[Article]?, ServiceError>) -> Void) async
}

public final class NewsService: NewsServiceProtocol {
    
    public init() {}
    
    public func getCryptoNews(completion: @escaping (Result<[Article]?, ServiceError>) -> Void) async {
        await ServiceManager.shared.request(NewsAPI.getCryptoNews, type: NewsDTO.self) { results in
            switch results {
            case .success(let data):
                completion(.success(data?.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
