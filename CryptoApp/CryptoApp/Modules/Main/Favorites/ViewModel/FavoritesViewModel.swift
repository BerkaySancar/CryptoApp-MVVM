//
//  FavoritesViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import Foundation

protocol FavoritesViewModelOutputs: AnyObject {
    func dataRefreshed()
    func setNavTitle(title: String)
    func prepareEmptyView()
    func prepareNavBarButtons()
    func removeNavBarButtons()
}

protocol FavoritesViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
    func numberOfRowsIn(section: Int) -> Int
    func didSelectRowAt(indexPath: IndexPath)
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel
    func removeItem(indexPath: IndexPath)
    func deleteAllTapped()
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    private weak var coordinator: AppCoordinator?
    private weak var view: FavoritesViewModelOutputs?
    private let storageManager: StorageManagerProtocol?
    
    private var favorites: [FavoriteCoinModel]?
    
    init(coordinator: AppCoordinator?, view: FavoritesViewModelOutputs?, storageManager: StorageManagerProtocol?) {
        self.coordinator = coordinator
        self.view = view
        self.storageManager = storageManager
    }
    
    private func getFavorites() {
        self.favorites = storageManager?.getItem(key: .favorites, type: [FavoriteCoinModel].self) ?? []
        self.view?.dataRefreshed()
    }
    
    func viewDidLoad() {
        view?.prepareEmptyView()
        getFavorites()
    }
    
    func viewWillAppear() {
        view?.setNavTitle(title: "Favorites")
        view?.prepareNavBarButtons()
        getFavorites()
    }
    
    func viewDidDisappear() {
        self.view?.removeNavBarButtons()
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        self.favorites?.count ?? 0
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        coordinator?.coinDetail(coinId: self.favorites?[indexPath.item].id)
    }
    
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel {
        return FavoriteCellViewModel(favCoin: self.favorites?[indexPath.row])
    }
    
    func removeItem(indexPath: IndexPath) {
        self.favorites?.remove(at: indexPath.row)
        storageManager?.addItem(key: .favorites, item: self.favorites)
        view?.dataRefreshed()
    }
    
    func deleteAllTapped() {
        self.favorites?.removeAll()
        storageManager?.addItem(key: .favorites, item: self.favorites)
        view?.dataRefreshed()
    }
}
