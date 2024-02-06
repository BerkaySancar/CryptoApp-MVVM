//
//  TotalBalanceCell.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 4.02.2024.
//

import UIKit

final class TotalBalanceCell: UITableViewCell {

    private lazy var customTotalBalanceView = TotalBalanceView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        addSubview(customTotalBalanceView)
        customTotalBalanceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customTotalBalanceView.widthAnchor.constraint(equalTo: widthAnchor),
            customTotalBalanceView.heightAnchor.constraint(equalTo: heightAnchor)])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
