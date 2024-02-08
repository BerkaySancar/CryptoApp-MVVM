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
    private let newsService: NewsServiceProtocol?
    
    private var articles: [ArticleModel]?
    
    init(coordinator: AppCoordinator, view: ArticleListViewModelOutputs, newsService: NewsServiceProtocol?) {
        self.coordinator = coordinator
        self.view = view
        self.newsService = newsService
    }
    
    func viewDidLoad() {
        view?.registerCell()
        view?.prepareBarButtonItem()
        
        Task {
            await self.getData()
        }
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
    
    private func getData() async {
        ActivityIndicatorManager.shared.startActivity()
        await newsService?.getCryptoNews { [weak self] results in
            guard let self else { return }
            ActivityIndicatorManager.shared.endActivity()
            switch results {
            case .success(let data):
                DispatchQueue.main.async {
                    if let data {
                        self.articles = data.map {
                            ArticleModel(
                                title: $0.title,
                                url: $0.url,
                                urlToImage: $0.urlToImage,
                                author: $0.author,
                                description: $0.description,
                                content: $0.content,
                                publishedAt: $0.publishedAt
                            )
                        }
                        self.view?.dataRefreshed()
                    }
                }
            case .failure(let error):
                AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Opps!", message: error.errorDescription))
            }
        }
    }
    
    func sortByDate() {
        if var articles {
            articles.sort { $0.publishedAt ?? "" > $1.publishedAt ?? ""}
            self.articles = articles
            self.view?.dataRefreshed()
        }
    }
}
