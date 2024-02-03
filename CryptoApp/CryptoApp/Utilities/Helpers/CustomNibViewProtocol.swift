//
//  CustomNibViewProtocol.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UIView

protocol CustomViewProtocol {
    var contentView: UIView! { get }
    
    func commonInit(for customViewName: String)
}

extension CustomViewProtocol where Self: UIView {
    func commonInit(for customViewName: String) {
        Bundle.main.loadNibNamed(customViewName, owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = .clear
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
