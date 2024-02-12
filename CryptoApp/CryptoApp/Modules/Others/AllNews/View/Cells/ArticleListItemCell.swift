//
//  ArticleListItemCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 8.02.2024.
//

import UIKit
import Kingfisher

final class ArticleListItemCell: UITableViewCell {
    
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var articleAuthorLabel: UILabel!
    @IBOutlet private weak var articleDateLabel: UILabel!
    
    var viewModel: ArticleListItemVM? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func configure() {
        self.articleAuthorLabel.text = viewModel?.author
        self.articleTitleLabel.text = viewModel?.title
        self.articleDateLabel.text = viewModel?.date?.convertNewsDateFormat
        if let url = URL(string: viewModel?.image ?? "") {
            articleImageView.kf.setImage(with: url)
        }
    }
}

