//
//  SplashViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import Foundation

protocol SplashViewModelOutputs: AnyObject {
    func setSplashTitle(title: String?)
}

protocol SplashViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
}

final class SplashViewModel: SplashViewModelProtocol {
    private weak var view: SplashViewModelOutputs?
    private weak var coordinator: AppCoordinator?
    private let isUserLoggedIn: Bool?
    private let remoteConfigManager: RemoteConfigManagerProtocol?
    
    init(
        view: SplashViewModelOutputs?,
        coordinator: AppCoordinator?,
        isUserLoggedIn: Bool,
        remoteConfigManager: RemoteConfigManagerProtocol?
    ) {
        self.view = view
        self.coordinator = coordinator
        self.isUserLoggedIn = isUserLoggedIn
        self.remoteConfigManager = remoteConfigManager
    }
    
    private func getTitleFromRemoteConfig() {
        DispatchQueue.main.async {
            self.remoteConfigManager?.getStringValue(key: .splashTitle) { [weak self] title in
                guard let self else { return }
                self.view?.setSplashTitle(title: title)
            }
        }
    }
    
    func viewDidLoad() {
        getTitleFromRemoteConfig()
        self.coordinator?.navigationController.isNavigationBarHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self else { return }
            if let isUserLoggedIn, isUserLoggedIn {
                self.coordinator?.tabBar()
            } else {
                self.coordinator?.onboarding()
            }
        }
    }
    
    func viewWillAppear() {
        self.coordinator?.navigationController.isNavigationBarHidden = false
    }
}
