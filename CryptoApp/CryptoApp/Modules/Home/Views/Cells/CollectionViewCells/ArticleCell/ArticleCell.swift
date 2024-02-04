//
//  ArticleCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

class ArticleCell: UICollectionViewCell {

    @IBOutlet private weak var articleTitleLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 24
    }

}
