//
//  SignUpViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var acceptButton: UIButton!
    @IBOutlet private weak var hidePassButton: UIButton!
    
    //MARK: ViewModel
    var viewModel: SignUpViewModelProtocol?

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign up"
        viewModel?.viewDidLoad()
    }
    
    //MARK: Actions
    @IBAction private func hidePassButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction private func acceptButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.backgroundColor = sender.isSelected ? .appYellow : .textFieldBackground
    }
    
    @IBAction private func signUpButtonTapped(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           self.acceptButton.isSelected {
            viewModel?.signUpButtonTapped(email: email, password: password)
        }
    }
    
    @IBAction private func loginButtonTapped(_ sender: Any) {
        viewModel?.toLoginTapped()
    }
    
}

//MARK: ViewModel Outputs
extension SignUpViewController: SignUpViewModelOutputs {
    func prepareHidePassButton() {
        self.hidePassButton.isSelected = false
        self.hidePassButton.setImage(.init(systemName: "eye.slash"), for: .normal)
        self.hidePassButton.setImage(.init(systemName: "eye"), for: .selected)
        passwordTextField.isSecureTextEntry = !hidePassButton.isSelected
    }
}
