//
//  ViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "login"
    }

    @IBAction func signUpTapped(_ sender: Any) {
        coordinator?.signUp()
    }
}

