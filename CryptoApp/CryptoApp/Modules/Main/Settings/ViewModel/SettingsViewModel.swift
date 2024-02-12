//
//  SettingsViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import Foundation

protocol SettingsViewModelOutputs: AnyObject {
    func setNavTitle(title: String)
}

protocol SettingsvViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func signOutTapped()
}

final class SettingsViewModel: SettingsvViewModelProtocol {
    private weak var coordinator: AppCoordinator?
    private weak var view: SettingsViewModelOutputs?
    private let authManager: AuthManagerProtocol?
    
    init(
        coordinator: AppCoordinator?,
        view: SettingsViewModelOutputs?,
        authManager: AuthManagerProtocol?
    ) {
        self.coordinator = coordinator
        self.authManager = authManager
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        view?.setNavTitle(title: "Settings")
    }
    
    func signOutTapped() {
        authManager?.signOut { [weak self] results in
            guard let self else { return }
            switch results {
            case .success:
                self.coordinator?.login()
            case .failure(let error):
                AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Sign out failed.", message: error.errorDescription))
            }
        }
    }
}
