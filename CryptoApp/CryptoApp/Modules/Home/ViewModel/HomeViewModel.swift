//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import Foundation

protocol HomeViewModelOutputs: AnyObject {
    
}

protocol HomeViewModelProtocol {
    func viewDidLoad()
    func numberOfRowsInSection(section: Int) -> Int
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
}

enum HomeViewCellType: CaseIterable {
    case totalBalance
    case topCoins
    case news
    
    static func getType(index: Int) -> HomeViewCellType {
        return self.allCases[index]
    }
    
    static func numberOfTypes() -> Int {
        return self.allCases.count
    }
}

final class HomeViewModel {
    weak var coordinator: AppCoordinator?
    weak var view: HomeViewModelOutputs?
    
    init(coordinator: AppCoordinator, view: HomeViewModelOutputs) {
        self.coordinator = coordinator
        self.view = view
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func viewDidLoad() {
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        HomeViewCellType.numberOfTypes()
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch HomeViewCellType.getType(index: indexPath.row) {
        case .totalBalance:
            240
        case .topCoins:
            240
        case .news:
            220
        }
    }
    
}
