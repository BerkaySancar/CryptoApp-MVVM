//
//  OnboardingViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

//MARK: ViewModel Responsibilities
protocol OnboardingViewModelProtocol {
    func viewDidLoad()
    func viewWillDisappear()
    func numberOfItemsInSection() -> Int
    func getCellVM(indexPath: IndexPath) -> BaseCellVM
    func nextButtonTapped(currentPage: Int)
    func signUpTapped()
    func loginTapped()
}

//MARK: ViewModel Outputs
protocol OnboardingViewModelOutputs: AnyObject {
    func prepareCollectionView()
    func preparePageControl()
    func scrollCollectionView(to item: Int)
    func prepareLoginSignUpButtons()
}

//MARK: ViewModel
final class OnboardingViewModel: OnboardingViewModelProtocol {
 
    private weak var coordinator: AppCoordinator?
    private weak var view: OnboardingViewModelOutputs?
    
    private let onboardings: [OnboardModel] = 
    [
        .init(
            title: "Welcome to Crypto App",
            imageName: "onboard1"
        ),
        .init(
            title: "Transaction Security",
            imageName: "onboard2"
        ),
        .init(
            title: "Fast and Reliable Market Updated",
            imageName: "onboard3"
        ),
        .init(
            title: "Fast and Flexible Trading",
            imageName: "onboard4"
        )
    ]
        
    init(coordinator: AppCoordinator?, view: OnboardingViewModelOutputs?) {
        self.coordinator = coordinator
        self.view = view
    }
        
    func viewDidLoad() {
        coordinator?.navigationController.setNavigationBarHidden(true, animated: true)
        view?.prepareCollectionView()
        view?.preparePageControl()
        view?.prepareLoginSignUpButtons()
    }
    
    func viewWillDisappear() {
        coordinator?.navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    func numberOfItemsInSection() -> Int {
        return onboardings.count
    }
    
    func getCellVM(indexPath: IndexPath) -> BaseCellVM {
        return OnboardingCellVM(model: self.onboardings[indexPath.row])
    }
    
    func nextButtonTapped(currentPage: Int) {
        view?.scrollCollectionView(to: currentPage + 1)
    }
    
    func signUpTapped() {
        coordinator?.signUp()
    }
    
    func loginTapped() {
        coordinator?.login()
    }
}
