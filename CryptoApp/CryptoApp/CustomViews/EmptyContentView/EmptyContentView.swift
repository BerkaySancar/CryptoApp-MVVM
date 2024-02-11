//
//  EmptyContentView.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 6.02.2024.
//

import Foundation
import UIKit.UIView

final class EmptyContentView: UIView, CustomViewProtocol {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(for: "EmptyContentView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
