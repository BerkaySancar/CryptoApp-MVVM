//
//  ExchangeCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 10.02.2024.
//

import UIKit
import Kingfisher

final class ExchangeCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet private weak var exchangeNameLabel: UILabel!
    @IBOutlet private weak var exchangeYearLabel: UILabel!
    @IBOutlet private weak var exchangeCountryLabel: UILabel!
    @IBOutlet private weak var exchangeVolumeLabel: UILabel!
    @IBOutlet private weak var exchangeImageView: UIImageView!
    @IBOutlet private weak var exchangeRankLabel: UILabel!
    @IBOutlet private weak var exchangeDescriptionLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    
    //MARK: ViewModel
    var viewModel: ExchangeCellVM! {
        didSet {
            configureUi()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func configureUi() {
        exchangeNameLabel.text = viewModel.name
        exchangeYearLabel.text = viewModel.establishedYear
        exchangeVolumeLabel.text = viewModel.tradeVolume
        exchangeCountryLabel.text = viewModel.country
        exchangeRankLabel.text = viewModel.rank
        exchangeDescriptionLabel.text = viewModel.description
        backView.backgroundColor = viewModel.bgColor
        if let url = URL(string: viewModel.image ?? "") {
            exchangeImageView.kf.setImage(with: url)
        }
    }
}
