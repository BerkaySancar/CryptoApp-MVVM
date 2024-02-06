//
//  SearchCoinCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 6.02.2024.
//

import UIKit
import Kingfisher

final class SearchCoinCell: UITableViewCell {

    @IBOutlet private weak var currencyImageView: UIImageView!
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var currencyRankLabel: UILabel!
    
    var viewModel: SearchCoinCellVM! {
        didSet {
            configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func configureUI() {
        self.currencyNameLabel.text = viewModel.name
        self.currencyRankLabel.text = String(viewModel.rank ?? 0)
        if let url = URL(string: viewModel.largeImage ?? "") {
            self.currencyImageView.kf.setImage(with: url)
        }
    }

}
