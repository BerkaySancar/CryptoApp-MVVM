//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation
import SystemConfiguration

final class ServiceManager {
    
    static let shared = ServiceManager()
    private let decoder = JSONDecoder()
    
    var isReachable: Bool {
        return checkReachability()
    }
    
    private init() {}
    
    func checkReachability() -> Bool {
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            
            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
        return false
    }
    
    func request<T: Codable>(_ request: URLRequestConvertible, type: T.Type, completion: @escaping (Result<T?, ServiceError>) -> Void) async {
        if isReachable {
            if #available(iOS 15.0, *) {
                guard let (data, response) = try? await URLSession.shared.data(for: request.urlRequest()) else
                {  completion(.failure(ServiceError.invalidURL))
                    print("||||||||||||||", "\n", request, "\nINVALID URL", "\n||||||||||||||")
                    return
                }
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200...299:
                        let decodedData = try? decoder.decode(T.self, from: data)
                        completion(.success(decodedData))
                        return
                    case 401:
                        completion(.failure(ServiceError.unauthorized))
                        print("||||||||||||||", "\n", request, "\n401", "\n|||||||||||||")
                        return
                    case 429:
                        completion(.failure(.rateLimit))
                        print("|||||||||||||||", "\n", request, "\n401", "\n||||||||||||||")
                    default:
                        completion(.failure(ServiceError.invalidResponse))
                        print("||||||||||||||", "\n", request, "\n\(response.statusCode)", "\n||||||||||||||")
                        return
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            completion(.failure(.noConnection))
            return
        }
    }
}
