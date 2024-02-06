//
//  File.swift
//  
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

public enum ServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidURLRequest
    case requestFailed
    case noConnection
    case unauthorized
    case rateLimit
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Something went wrong. Try again."
        case .invalidResponse:
            return "Something went wrong. Try again."
        case .requestFailed:
            return "Request failed. Try again."
        case .invalidURLRequest:
            return "Something went wrong. Try again."
        case .noConnection:
            return "No internet connection."
        case .unauthorized:
           return "Unauthorized request."
        case .rateLimit:
            return "You've exceeded the Rate Limit."
        }
    }
}
