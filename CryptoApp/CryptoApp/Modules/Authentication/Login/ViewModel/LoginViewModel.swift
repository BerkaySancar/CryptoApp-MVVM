//
//  LoginViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

//MARK: Login View Model Outputs
protocol LoginViewModelOutputs: AnyObject {
    func prepareHidePassButton()
}

// MARK: Login View Model Responsibilities
protocol LoginViewModelProtocol {
    func viewDidLoad()
    func loginTapped(email: String, password: String)
    func createAccountTapped()
}

//MARK: Login View Model
final class LoginViewModel: LoginViewModelProtocol {
    
    private weak var coordinator: AppCoordinator?
    private weak var view: LoginViewModelOutputs?
    private let authManager: AuthManagerProtocol?
    
    init(coordinator: AppCoordinator, view: LoginViewModelOutputs, authManager: AuthManagerProtocol) {
        self.coordinator = coordinator
        self.view = view
        self.authManager = authManager
    }
    
    func viewDidLoad() {
        view?.prepareHidePassButton()
    }
    
    func loginTapped(email: String, password: String) {
        if email != "" && password != "" {
            authManager?.login(email: email, password: password, completion: { [weak self] results in
                guard let self else { return }
                switch results {
                case .success(_):
                    self.coordinator?.tabBar()
                case .failure(let error):
                    AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Error.", message: error.localizedDescription))
                }
            })
        } else {
            AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Opps!", message: "Email & password cannot be empty."))
        }
        
    }
    
    func createAccountTapped() {
        self.coordinator?.signUp()
    }
}
