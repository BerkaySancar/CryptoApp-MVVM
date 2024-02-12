//
//  OnboardingCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    
    //MARK: Cell Identifier
    static let identifier = "OnboardingCell"
    
    //MARK: Outlets
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellLabel: UILabel!
    
    //MARK: ViewModel
    var viewModel: OnboardingCellVM? {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateCell() {
        if let viewModel {
            self.cellLabel.text = viewModel.title
            self.cellImageView.image = UIImage(named: viewModel.imageName)
        }
    }
}
