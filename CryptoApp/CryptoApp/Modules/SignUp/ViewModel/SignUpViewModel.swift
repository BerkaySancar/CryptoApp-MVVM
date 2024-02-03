//
//  SignUpViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

protocol SignUpViewModelOutputs: AnyObject {
    func prepareHidePassButton()
}

//MARK: ViewModel Responsibilities
protocol SignUpViewModelProtocol {
    func viewDidLoad()
    func signUpButtonTapped(email: String, password: String)
    func toLoginTapped()
}

//MARK: ViewModel
final class SignUpViewModel: SignUpViewModelProtocol {
    
    private weak var coordinator: AppCoordinator?
    private weak var view: SignUpViewModelOutputs?
    private let authManager: AuthManagerProtocol?
    
    init(coordinator: AppCoordinator, view: SignUpViewModelOutputs, authManager: AuthManagerProtocol?) {
        self.coordinator = coordinator
        self.view = view
        self.authManager = authManager
    }
    
    func viewDidLoad() {
        view?.prepareHidePassButton()
    }
    
    func signUpButtonTapped(email: String, password: String) {
        if email.isValidEmail() && password.isPasswordValid() {
            authManager?.signUp(email: email, password: password, completion: { [weak self] results in
                switch results {
                case .success:
                    self?.coordinator?.login()
                case .failure(let error):
                    AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Error!", message: error.localizedDescription))
                }
            })
        } else {
            AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Error", message: GeneralError.invalidEmailOrPassword.localizedDescription))
        }
    }
    
    func toLoginTapped() {
        coordinator?.login()
    }
}
