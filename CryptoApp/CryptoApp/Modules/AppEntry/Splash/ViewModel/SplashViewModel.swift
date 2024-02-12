//
//  SplashViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import Foundation

protocol SplashViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
}

final class SplashViewModel: SplashViewModelProtocol {
    private weak var coordinator: AppCoordinator?
    private let isUserLoggedIn: Bool?
    
    init(coordinator: AppCoordinator?, isUserLoggedIn: Bool) {
        self.coordinator = coordinator
        self.isUserLoggedIn = isUserLoggedIn
    }
    
    func viewDidLoad() {
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
