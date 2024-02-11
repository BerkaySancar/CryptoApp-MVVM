//
//  SplashViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    var viewModel: SplashViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
    }
}
