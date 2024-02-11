//
//  StorageManager.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import Foundation

enum StorageType: String {
    case favorites = "favorites"
    case topCoins = "topCoins"
    case news = "news"
    case exchanges = "exchanges"
}

protocol StorageManagerProtocol {
    func addItem<T: Codable>(key: StorageType, item: T)
    func getItem<T: Codable>(key: StorageType, type: T.Type) -> T?
    func removeItem(key: StorageType)
}

final class StorageManager: StorageManagerProtocol {
    
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func addItem<T: Codable>(key: StorageType, item: T) {
        let encodedData = try? encoder.encode(item)
        userDefaults.set(encodedData, forKey: key.rawValue)
    }
    
    func getItem<T: Codable>(key: StorageType, type: T.Type) -> T? {
        if let data = userDefaults.data(forKey: key.rawValue),
           let decodedItem = try? decoder.decode(type, from: data) {
            return decodedItem
        }
        return nil
    }
    
    func removeItem(key: StorageType) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
