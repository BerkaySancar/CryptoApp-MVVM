//
//  AppCoordinator.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UINavigationController
import APIService


protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        home()
    }
    
    func onboarding() {
        let onboardingVC = OnboardingViewController.instantiateFromStoryboard("Onboarding")
        let viewModel = OnboardingViewModel(
            coordinator: self,
            view: onboardingVC
        )
        onboardingVC.viewModel = viewModel
        self.navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    func login() {
        let login = LoginViewController.instantiateFromStoryboard("Authentication")
        let viewModel = LoginViewModel(
            coordinator: self,
            view: login,
            authManager: AuthManager.shared
        )
        login.viewModel = viewModel
        self.navigationController.setViewControllers([login], animated: true)
    }
    
    func signUp() {
        let signUp = SignUpViewController.instantiateFromStoryboard("Authentication")
        let viewModel = SignUpViewModel(
            coordinator: self,
            view: signUp,
            authManager: AuthManager.shared
        )
        signUp.viewModel = viewModel
        self.navigationController.setViewControllers([signUp], animated: true)
    }
    
    func home() {
        let home = HomeViewController.instantiateFromStoryboard("Main")
        let viewModel = HomeViewModel(
            coordinator: self,
            view: home,
            cryptoService: CryptoService(),
            newsService: NewsService()
        )
        home.viewModel = viewModel
        self.navigationController.setViewControllers([home], animated: true)
    }
}


