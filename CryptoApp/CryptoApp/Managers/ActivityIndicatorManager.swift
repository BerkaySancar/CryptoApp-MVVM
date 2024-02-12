//
//  ActivityIndicatorManager.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit

final class ActivityIndicatorManager {
    
    static let shared = ActivityIndicatorManager()
    
    private lazy var aiv = UIActivityIndicatorView()
    
    private init() {}
    
    private func configure() {
        if let keyWindow {
            keyWindow.addSubview(self.aiv)
            aiv.startAnimating()
            aiv.style = .large
            aiv.color = .textFieldBackground
            aiv.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(
                [aiv.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
                 aiv.centerYAnchor.constraint(equalTo: keyWindow.centerYAnchor)]
            )
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async { [weak self] in
            self?.configure()
        }
    }
    
    func endActivity() {
        DispatchQueue.main.async { [weak self] in
            self?.aiv.removeFromSuperview()
        }
    }
}
