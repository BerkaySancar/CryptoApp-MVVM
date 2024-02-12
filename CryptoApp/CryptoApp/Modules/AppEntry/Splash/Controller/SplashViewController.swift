//
//  SplashViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    //MARK: ViewModel
    var viewModel: SplashViewModelProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.viewWillAppear()
    }
}
