//
//  ArticleListViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 8.02.2024.
//

import APIService
import Foundation

protocol ArticleListViewModelOutputs: AnyObject {
    func setNavTitle(title: String)
    func registerCell()
    func dataRefreshed()
    func prepareBarButtonItem()
}

protocol ArticleListViewModelProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection(section: Int) -> Int
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel?
    func didSelectItemAt(indexPath: IndexPath)
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func sortByDate()
}

final class ArticleListViewModel: ArticleListViewModelProtocol {
    private weak var coordinator: AppCoordinator?
    private weak var view: ArticleListViewModelOutputs?
    
    private var articles: [ArticleModel]?
    
    init(coordinator: AppCoordinator, view: ArticleListViewModelOutputs, articles: [ArticleModel]?) {
        self.coordinator = coordinator
        self.view = view
        self.articles = articles
    }
    
    func viewDidLoad() {
        view?.registerCell()
        view?.prepareBarButtonItem()
    }
    
    func viewWillAppear() {
        view?.setNavTitle(title: "Article List")
    }
    
    func getCellViewModel(indexPath: IndexPath) -> BaseCellViewModel? {
        return ArticleListItemVM(model: self.articles?[indexPath.row])
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        if let article = self.articles?[indexPath.row] {
            self.coordinator?.newsDetail(article: article)
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func sortByDate() {
        if var articles {
            articles.sort { $0.publishedAt ?? "" > $1.publishedAt ?? ""}
            self.articles = articles
            self.view?.dataRefreshed()
        }
    }
}
