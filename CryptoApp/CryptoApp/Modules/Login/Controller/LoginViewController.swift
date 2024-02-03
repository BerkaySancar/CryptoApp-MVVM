//
//  ViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var hidePasswordButton: UIButton!
    
    //MARK: ViewModel
    var viewModel: LoginViewModelProtocol?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Login"
        viewModel?.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction private func loginTapped(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            viewModel?.loginTapped(email: email, password: password)
        }
    }
    
    @IBAction private func forgotPasswordTapped(_ sender: Any) {
        AlertManager.shared.showAlert(type: .passwordReset)
    }
    
    @IBAction private func createAccountTapped(_ sender: Any) {
        viewModel?.createAccountTapped()
    }
    
    @IBAction private func hidePassButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
}

//MARK: View Model Outputs
extension LoginViewController: LoginViewModelOutputs {
    
    func prepareHidePassButton() {
        self.hidePasswordButton.isSelected = false
        self.hidePasswordButton.setImage(.init(systemName: "eye.slash"), for: .normal)
        self.hidePasswordButton.setImage(.init(systemName: "eye"), for: .selected)
        passwordTextField.isSecureTextEntry = !hidePasswordButton.isSelected
    }
}
