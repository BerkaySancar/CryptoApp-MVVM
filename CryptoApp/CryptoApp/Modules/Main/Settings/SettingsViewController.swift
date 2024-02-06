//
//  SettingsViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.textColor = .appYellow
        
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     label.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            AuthManager.shared.signOut { results in
                switch results {
                case .success(let success):
                    self.coordinator?.login()
                case .failure(let failure):
                    AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "SignOUT ERROR", message: "asdasd"))
                }
            }
        }
    }
    
}
