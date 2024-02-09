//
//  TopCoinCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit
import Kingfisher

final class TopCoinCell: UICollectionViewCell {
    
    @IBOutlet private weak var symbolImageView: UIImageView!
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var currencyPriceLabel: UILabel!
    @IBOutlet private weak var pricePercantageLabel: UILabel!
    
    var viewModel: TopCoinCellVM? {
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
           let image = viewModel.image {
            symbolImageView.kf.setImage(with: URL(string: image))
            currencyNameLabel.text = viewModel.name
            currencyPriceLabel.text = "$" + String(describing: viewModel.currentPrice ?? 0)
            pricePercantageLabel.text = "%" + String(format: "%.3f", viewModel.priceChangeCPercentage24h ?? "")
            pricePercantageLabel.textColor = viewModel.priceChangeCPercentage24h ?? 0 > 0 ? .systemGreen : .systemRed
        }
    }
}
