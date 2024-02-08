
import Foundation

enum CryptoAPI: URLRequestConvertible {
    
    case getCoins(coinId: String?, currency: String, perPage: Int, page: Int)
    case searchCoin(query: String)
    case searchTrendings
    case getMarketChartPrices(coinId: String, currency: String)
    case getCoinDetail(coinId: String)
        
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
        case .getMarketChartPrices(let coinId, _):
            "coins/\(coinId)/market_chart"
        case .getCoinDetail(let coinId):
            "coins/\(coinId)"
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
        case .getMarketChartPrices:
            .get
        case .getCoinDetail:
            .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCoins(let coinId, let currency, let perPage, let page):
            return [
                "vs_currency": currency,
                "order": "market_cap_desc",
                "per_page": perPage,
                "page": page,
                "sparkline": false,
                "locale": "en",
                "ids": coinId ?? ""
            ]
        case .searchCoin(let query):
            return ["query": query]
        case .searchTrendings:
            return nil
        case .getMarketChartPrices(_, let currency):
            return [
                "vs_currency": currency,
                "interval": "daily",
                "days": 440
            ]
        case .getCoinDetail:
            return nil
        }
    }
}
