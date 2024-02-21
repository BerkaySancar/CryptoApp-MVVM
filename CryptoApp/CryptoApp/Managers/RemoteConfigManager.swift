//
//  RemoteConfigManager.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 21.02.2024.
//

import Foundation
import FirebaseRemoteConfig

enum RemoteConfigKey: String {
    case splashTitle = "splashTitle"
}

protocol RemoteConfigManagerProtocol {
    func getStringValue(key: RemoteConfigKey, completion: @escaping (String?) -> Void)
}

final class RemoteConfigManager: RemoteConfigManagerProtocol {
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let settings = RemoteConfigSettings()
    
    init() {
        configure()
    }
    
    private func configure() {
        settings.minimumFetchInterval = 0 //tekrar bir getirme isteği gönderilmeden önce geçmesi gereken minimum süre
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        remoteConfig.activate()
    }
    
    func getStringValue(key: RemoteConfigKey, completion: @escaping (String?) -> Void) {
        self.remoteConfig.fetch { (status, error) in
            if status == .success {
                let strValue = self.remoteConfig.configValue(forKey: key.rawValue).stringValue!
                completion(strValue)
            }
        }
    }
}

