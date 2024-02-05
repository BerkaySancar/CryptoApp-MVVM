
import Foundation

enum CryptoAPI: URLRequestConvertible {
    
    case getCoins(currency: String, perPage: Int, page: Int)
    
    var baseURL: URL {
        .init(string: "https://api.coingecko.com/api/v3/coins/")!
    }
    
    var path: String {
        switch self {
        case .getCoins:
            "markets"
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .getCoins:
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
        }
    }
}
