//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public enum NewsAPI: URLRequestConvertible {
    
    case getCryptoNews
    
    var baseURL: URL {
        return .init(string: "https://newsapi.org/v2")!
    }
    
    var path: String {
        switch self {
        case .getCryptoNews:
            "everything"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .getCryptoNews:
                .get
        }
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        ["q": "Crypto",
         "apiKey": "e2e9c86d8e11426f9b34df9bb9a1b860"
        ]
    }
}
