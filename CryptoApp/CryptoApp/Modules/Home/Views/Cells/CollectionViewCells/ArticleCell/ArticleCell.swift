//
//  ArticleCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit
import Kingfisher

final class ArticleCell: UICollectionViewCell {

    //MARK: Outlets
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    //MARK: ViewModel
    var viewModel: ArticleCellViewModel? {
        didSet {
            configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 24
    }
    
    private func configureUI() {
        if let viewModel,
           let image = viewModel.urlToImage {
            self.articleTitleLabel.text = viewModel.title
            self.articleImageView.kf.setImage(with: URL(string: image))
            self.dateLabel.text = viewModel.author
        }
    }
}
