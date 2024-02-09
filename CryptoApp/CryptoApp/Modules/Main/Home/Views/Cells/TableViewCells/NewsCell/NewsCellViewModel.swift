//
//  NewsCellViewModel.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation
import UIKit.UIScreen

protocol NewsCellViewModelDelegate: AnyObject {
    func didSelectItem(item: ArticleModel?)
    func seeAllArticlesTapped()
}

final class NewsCellViewModel: BaseCellViewModel {
    
    weak var delegate: NewsCellViewModelDelegate?
    private var articles: [ArticleModel]?
    
    init(articles: [ArticleModel]?) {
        self.articles = articles
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return articles?.prefix(8).count ?? 0
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width / 1.15, height: 140)
    }
    
    func getCellVM(indexPath: IndexPath) -> BaseCellViewModel {
        return ArticleCellViewModel(model: self.articles?.prefix(8)[indexPath.row])
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        self.delegate?.didSelectItem(item: self.articles?[indexPath.item])
    }
    
    func seeAllArticlesTapped() {
        self.delegate?.seeAllArticlesTapped()
    }
}
