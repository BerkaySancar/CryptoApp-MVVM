//
//  TotalBalanceView.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

final class TotalBalanceView: UIView, CustomViewProtocol {

    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var profitLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(for: "TotalBalanceView")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(for: "TotalBalanceView")
        fatalError("init(coder:) has not been implemented")
    }
}
