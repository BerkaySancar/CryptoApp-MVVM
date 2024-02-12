//
//  ArticleListItemVM.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 8.02.2024.
//

import Foundation

final class ArticleListItemVM: BaseCellViewModel {
    
    private var model: ArticleModel?
    
    init(model: ArticleModel?) {
        self.model = model
    }
    
    var author: String? {
        return model?.author
    }
    
    var title: String? {
        return model?.title
    }
    
    var image: String? {
        return model?.urlToImage
    }
    
    var date: String? {
        return model?.publishedAt
    }
}
