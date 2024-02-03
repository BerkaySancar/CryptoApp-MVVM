//
//  ViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var hidePasswordButton: UIButton!
    
    var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel?.viewDidLoad()
    }
    
    @IBAction private func loginTapped(_ sender: Any) {
        
    }
    
    @IBAction private func forgotPasswordTapped(_ sender: Any) {
        
    }
    
    @IBAction private func createAccountTapped(_ sender: Any) {
        
    }
    
    @IBAction private func hidePassButtonTapped(_ sender: Any) {
        self.hidePasswordButton.isSelected.toggle()
    }
}

extension LoginViewController: LoginViewModelOutputs {
    
    func prepareHidePassButton() {
        self.hidePasswordButton.isSelected = false
        self.hidePasswordButton.setImage(.init(systemName: "eye.slash"), for: .normal)
        self.hidePasswordButton.setImage(.init(systemName: "eye"), for: .selected)
    }
}
