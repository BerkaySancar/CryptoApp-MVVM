//
//  FavoriteCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 11.02.2024.
//

import UIKit
import Kingfisher

final class FavoriteCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet private weak var favoriteImageView: UIImageView!
    @IBOutlet private weak var favoriteNameLabel: UILabel!
    @IBOutlet private weak var favoriteSymbolLabel: UILabel!
    
    //MARK: ViewModel
    var viewModel: FavoriteCellViewModel! {
        didSet {
            configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    private func configureUI() {
        favoriteNameLabel.text = viewModel.name ?? ""
        favoriteSymbolLabel.text = viewModel.symbol ?? ""
        if let url = URL(string: viewModel.image ?? "") {
            favoriteImageView.kf.setImage(with: url)
        }
    }
}
