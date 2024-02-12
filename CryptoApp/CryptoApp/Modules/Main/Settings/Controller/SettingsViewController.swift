//
//  SettingsViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    //MARK: ViewModel
    var viewModel: SettingsvViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppear()
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        viewModel?.signOutTapped()
    }
}

//MARK: ViewModel Outputs
extension SettingsViewController: SettingsViewModelOutputs {
    
    func setNavTitle(title: String) {
        self.tabBarController?.navigationItem.title = "Settings"
    }
}
