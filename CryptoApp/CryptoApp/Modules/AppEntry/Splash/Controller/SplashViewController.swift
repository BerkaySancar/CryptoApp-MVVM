//
//  SplashViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import UIKit

final class SplashViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var splashTitle: UILabel!
    
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

//MARK: View Model Outputs
extension SplashViewController: SplashViewModelOutputs {
    
    func setSplashTitle(title: String?) {
        self.splashTitle.text = title
    }
}
