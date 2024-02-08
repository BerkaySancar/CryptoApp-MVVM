//
//  OnboardingViewController.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet private weak var onboardingCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    //MARK: ViewModel
    var viewModel: OnboardingViewModelProtocol?

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.viewWillDisappear()
    }
    
    //MARK: Private Class Funcs
    private func setButtonVisibility(currentPage: Int) {
        guard let viewModel else { return }
        
        let isLastItemVisible = currentPage + 1 == viewModel.numberOfItemsInSection()
        signUpButton.isHidden = !isLastItemVisible
        loginButton.isHidden = !isLastItemVisible
        pageControl.isHidden = isLastItemVisible
        nextButton.isHidden = isLastItemVisible
        skipButton.isHidden = isLastItemVisible
    }
 
    //MARK: Actions
    @IBAction private func skipButtonTapped(_ sender: Any) {
        guard let viewModel else { return }
        onboardingCollectionView.isPagingEnabled = false
        setButtonVisibility(currentPage: viewModel.numberOfItemsInSection() - 1)
        onboardingCollectionView.scrollToItem(at: IndexPath(item: viewModel.numberOfItemsInSection() - 1, section: 0), at: .centeredHorizontally, animated: true)
        onboardingCollectionView.isPagingEnabled = true
    }
    
    @IBAction private func nextButtonTapped(_ sender: Any) {
        viewModel?.nextButtonTapped(currentPage: pageControl.currentPage)
        self.setButtonVisibility(currentPage: pageControl.currentPage)
    }
    
    @IBAction private func signUpTapped(_ sender: Any) {
        viewModel?.signUpTapped()
    }
    
    @IBAction private func loginTapped(_ sender: Any) {
        viewModel?.loginTapped()
    }
}

// MARK: View Model Outputs
extension OnboardingViewController: OnboardingViewModelOutputs {
    
    func prepareCollectionView() {
        onboardingCollectionView.register(.init(nibName: "OnboardingCell",
                                                bundle: nil),
                                          forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
    
    func preparePageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel?.numberOfItemsInSection() ?? 0
        pageControl.currentPageIndicatorTintColor = .appYellow
    }
    
    func scrollCollectionView(to item: Int) {
        onboardingCollectionView.isPagingEnabled = false // important for work correctly
        pageControl.currentPage = item
        onboardingCollectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func prepareLoginSignUpButtons() {
        signUpButton.layer.borderColor = UIColor.appYellow.cgColor
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.cornerRadius = 8
        
        loginButton.layer.cornerRadius = 8
    }
}

// MARK: CollectionView Delegates & DataSource & FlowLayout
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        cell.viewModel = viewModel?.getCellVM(indexPath: indexPath) as? OnboardingCellVM
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        self.setButtonVisibility(currentPage: pageControl.currentPage)
    }
}
