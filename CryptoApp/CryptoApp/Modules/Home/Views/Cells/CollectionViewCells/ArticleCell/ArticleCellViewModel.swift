//
//  ArticleCellVM.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 5.02.2024.
//

import Foundation

final class ArticleCellViewModel: BaseCellVM {
    
    private var model: ArticleModel?
    
    init(model: ArticleModel?) {
        self.model = model
    }
    
    var title: String? {
        model?.title
    }
    
    var author: String? {
        model?.author
    }

    var urlToImage: String? {
        model?.urlToImage
    }
}
