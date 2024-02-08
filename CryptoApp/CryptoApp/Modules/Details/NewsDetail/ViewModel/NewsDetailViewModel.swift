//
//  NewsDetailViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 7.02.2024.
//

import Foundation

//MARK: View Model Outputs
protocol NewsDetailViewModelOutputs: AnyObject {
    func showArticle(article: ArticleModel?)
    func prepareActionButton()
    func presentActionController(url: URL)
}

//MARK: View Model Responsibilities
protocol NewsDetailViewModelProtocol {
    func viewDidLoad()
    func didTapToReadWebView()
    func actionButtonTapped()
}

//MARK: View Model
final class NewsDetailViewModel: NewsDetailViewModelProtocol {
    
    private weak var coordinator: AppCoordinator?
    private weak var view: NewsDetailViewModelOutputs?
    
    private var article: ArticleModel?
    
    init(coordinator: AppCoordinator?, view: NewsDetailViewModelOutputs?, article: ArticleModel) {
        self.coordinator = coordinator
        self.view = view
        self.article = article
    }
    
    func viewDidLoad() {
        view?.showArticle(article: self.article)
        view?.prepareActionButton()
    }
    
    func didTapToReadWebView() {
        if let urlStr = article?.url {
            coordinator?.safari(urlString: urlStr)
        }
    }
    
    func actionButtonTapped() {
        guard let urlStr = article?.url,
              let url = URL(string: urlStr) else { return }
        view?.presentActionController(url: url)
    }
}
