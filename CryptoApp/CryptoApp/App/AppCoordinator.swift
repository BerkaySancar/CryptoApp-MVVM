//
//  AppCoordinator.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UINavigationController


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
        onboarding()
    }
    
    func onboarding() {
        let onboardingVC = OnboardingViewController.instantiateFromStoryboard("Onboarding")
        let viewModel = OnboardingViewModel(coordinator: self, view: onboardingVC)
        onboardingVC.viewModel = viewModel
        self.navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    func login() {
        let login = LoginViewController.instantiateFromStoryboard("Authentication")
        login.coordinator = self
        self.navigationController.setViewControllers([login], animated: true)
    }
    
    func signUp() {
        let signUp = SignUpViewController.instantiateFromStoryboard("Authentication")
        self.navigationController.setViewControllers([signUp], animated: true)
    }
}


