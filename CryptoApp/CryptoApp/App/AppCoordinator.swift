//
//  AppCoordinator.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UINavigationController
import SwiftUI
import APIService
import SafariServices

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start(isLoggedIn: Bool)
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var tabBarController: UITabBarController?
    
    //dependencies
    private let storageManager: StorageManagerProtocol = StorageManager()
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - App Start
    func start(isLoggedIn: Bool) {
        if isLoggedIn {
            tabBar()
        } else {
            onboarding()
        }
    }
    
    //MARK: - Onboarding
    func onboarding() {
        let onboardingVC = OnboardingViewController.instantiateFromStoryboard("Onboarding")
        let viewModel = OnboardingViewModel(
            coordinator: self,
            view: onboardingVC
        )
        onboardingVC.viewModel = viewModel
        self.navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    //MARK: - Login
    func login() {
        let login = LoginViewController.instantiateFromStoryboard("Authentication")
        let viewModel = LoginViewModel(
            coordinator: self,
            view: login,
            authManager: AuthManager.shared
        )
        login.viewModel = viewModel
        self.navigationController.setViewControllers([login], animated: true)
    }
    
    //MARK: - SignUp
    func signUp() {
        let signUp = SignUpViewController.instantiateFromStoryboard("Authentication")
        let viewModel = SignUpViewModel(
            coordinator: self,
            view: signUp,
            authManager: AuthManager.shared
        )
        signUp.viewModel = viewModel
        self.navigationController.setViewControllers([signUp], animated: true)
    }
    
    //MARK: - TabBar
    func tabBar() {
        tabBarController = UITabBarController()
        tabBarController?.tabBar.tintColor = .appYellow
        tabBarController?.setViewControllers(
            [
                home(),
                search(),
                favorites(),
                settings()
            ],
            animated: true
        )
        
        //MARK: HOME
        tabBarController?.viewControllers?[0].tabBarItem.image = .init(systemName: "house")
        tabBarController?.viewControllers?[0].tabBarItem.selectedImage = .init(systemName: "house.fill")
        tabBarController?.viewControllers?[0].tabBarItem.title = "Home"
        
        //MARK: SEARCH
        tabBarController?.viewControllers?[1].tabBarItem.image = .init(systemName: "magnifyingglass.circle")
        tabBarController?.viewControllers?[1].tabBarItem.selectedImage = .init(systemName: "magnifyingglass.circle.fill")
        tabBarController?.viewControllers?[1].tabBarItem.title = "Search"
        
        //MARK: Favorites
        tabBarController?.viewControllers?[2].tabBarItem.image = .init(systemName: "heart")
        tabBarController?.viewControllers?[2].tabBarItem.selectedImage = .init(systemName: "heart.fill")
        tabBarController?.viewControllers?[2].tabBarItem.title = "Favorites"
        
        //MARK: Settings
        tabBarController?.viewControllers?[3].tabBarItem.image = .init(systemName: "gearshape")
        tabBarController?.viewControllers?[3].tabBarItem.selectedImage = .init(systemName: "gearshape.fill")
        tabBarController?.viewControllers?[3].tabBarItem.title = "Settings"
        
        if let tabBarController {
            self.navigationController.setViewControllers([tabBarController], animated: true)
        }
    }
        
    //MARK: - Home
    func home() -> HomeViewController {
        let home = HomeViewController.instantiateFromStoryboard("Main")
        let viewModel = HomeViewModel(
            coordinator: self,
            view: home,
            cryptoService: CryptoService(),
            newsService: NewsService()
        )
        home.viewModel = viewModel
        return home
    }
    
    //MARK: - Search
    func search() -> SearchViewController {
        let search = SearchViewController.instantiateFromStoryboard("Main")
        let viewModel = SearchViewModel(
            view: search,
            coordinator: self,
            cryptoService: CryptoService()
        )
        search.viewModel = viewModel
        return search
    }
    
    func favorites() -> FavoritesViewController {
        let favorites = FavoritesViewController.instantiateFromStoryboard("Main")
        let viewModel = FavoritesViewModel(
            coordinator: self,
            view: favorites,
            storageManager: self.storageManager
        )
        favorites.viewModel = viewModel
        return favorites
    }
    
    //MARK: -  Settings
    func settings() -> SettingsViewController {
        let settings = SettingsViewController()
        settings.coordinator = self
        return settings
    }
    
    //MARK: - NewsDetail
    func newsDetail(article: ArticleModel) {
        let detail = NewsDetailViewController(nibName: "NewsDetailView", bundle: nil)
        let viewModel = NewsDetailViewModel(
            coordinator: self,
            view: detail,
            article: article
        )
        detail.viewModel = viewModel
        
        self.navigationController.pushViewController(detail, animated: true)
    }
    
    //MARK: ArticleList
    func articleList(articles: [ArticleModel]?) {
        let articleList = ArticleListTableViewController(nibName: "ArticleListTableView", bundle: nil)
        let viewModel = ArticleListViewModel(coordinator: self, view: articleList, articles: articles)
        articleList.viewModel = viewModel
        
        self.navigationController.pushViewController(articleList, animated: true)
    }
    
    //MARK: - Safari Controller for NewsDetail
    func safari(urlString: String) {
        if let url = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            self.navigationController.present(safariVC, animated: true)
        }
    }
    
    //MARK: - CoinDetail - SwiftUI
    func coinDetail(coinId: String?) {
        let viewModel = CoinDetailViewModel(
            coordinator: self,
            cryptoService: CryptoService(),
            coinId: coinId,
            storageManager: self.storageManager
        )
        let view = CoinDetailView(viewModel: viewModel)
        let hostingVC = UIHostingController(rootView: view)
        self.navigationController.pushViewController(hostingVC, animated: true)
    }
    
    func currencies(coins: [CoinModel]?) {
        let coinList = CurrenciesViewController(nibName: "CurrenciesView", bundle: nil)
        let viewModel = CurrenciesViewModel(coordinator: self, view: coinList, coins: coins)
        coinList.viewModel = viewModel
        
        self.navigationController.pushViewController(coinList, animated: true)
    }
}
