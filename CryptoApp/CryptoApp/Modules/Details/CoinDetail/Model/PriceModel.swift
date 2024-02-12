//
//  PriceModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 7.02.2024.
//

import Foundation

struct Price: Identifiable {
    var id = UUID().uuidString
    var unixTime: Double
    var day: Date {
        let timestamp = TimeInterval(unixTime) / 1000
        return Date(timeIntervalSince1970: timestamp)
    }
    var price: Double
//
//    static var sample: [Price] =
//    [
//        .init(unixTime: 1702091200000, price: 43500),
//        .init(unixTime: 1707091200000, price: 43500),
//        .init(unixTime: 1707177600000, price: 44500),
//        .init(unixTime: 1707264000000, price: 46500),
//        .init(unixTime: 1707310921000, price: 47500),
//        .init(unixTime: 1707410922000, price: 48500),
//        .init(unixTime: 1707510921000, price: 49500),
//        .init(unixTime: 1707610921000, price: 60500),
//        .init(unixTime: 1707710921000, price: 70500)
//    ]
}
