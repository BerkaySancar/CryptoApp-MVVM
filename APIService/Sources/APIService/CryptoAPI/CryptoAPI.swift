
import Foundation

enum CryptoAPI: URLRequestConvertible {
    
    case getCoins(currency: String, perPage: Int, page: Int)
    case searchCoin(query: String)
    case searchTrendings
        
    var baseURL: URL {
        .init(string: "https://api.coingecko.com/api/v3")!
    }
    
    var path: String {
        switch self {
        case .getCoins:
            "coins/markets"
        case .searchCoin:
            "search"
        case .searchTrendings:
            "search/trending"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .getCoins:
            .get
        case .searchCoin:
            .get
        case .searchTrendings:
            .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCoins(let currency, let perPage, let page):
            ["vs_currency": currency,
             "order": "market_cap_desc",
             "per_page": perPage,
             "page": page,
             "sparkline": false,
             "locale": "en"
            ]
        case .searchCoin(query: let query):
            ["query": query]
        case .searchTrendings:
            nil
        }
    }
}
