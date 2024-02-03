//
//  LoginViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

protocol LoginViewModelOutputs: AnyObject {
    func prepareHidePassButton()
}

protocol LoginViewModelProtocol {
    func viewDidLoad()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    weak var coordinator: AppCoordinator?
    weak var view: LoginViewModelOutputs?
    
    init(coordinator: AppCoordinator, view: LoginViewModelOutputs) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func viewDidLoad() {
        view?.prepareHidePassButton()
    }
}
