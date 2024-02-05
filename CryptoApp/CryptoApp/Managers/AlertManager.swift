//
//  AlertManager.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UIView

enum AlertType {
    case titleMessageDismiss(title: String, message: String)
    case passwordReset
    case signUpSuccess
}

final class AlertManager {
    
    static let shared = AlertManager()
    
    private var alertView: AppAlertView?
    
    private init() {}
    
    func showAlert(type: AlertType) {
        if alertView == nil {
            alertView = AppAlertView()
        }
        
        switch type {
        case .titleMessageDismiss(let title, let message):
            alertView?.titleLabel.text = title
            alertView?.messageLabel.text = message
            alertView?.actionButton.setTitle("OK", for: .normal)
            alertView?.alertTextField.isHidden = true
            
        case .passwordReset:
            alertView?.titleLabel.text = "Password Reset"
            alertView?.messageLabel.isHidden = true
            alertView?.alertTextField.isHidden = false
            alertView?.alertTextField.placeholder = "Enter your email"
            alertView?.actionButton.setTitle("Reset", for: .normal)
            
        case .signUpSuccess:
            alertView?.titleLabel.text = "Done!"
            alertView?.messageLabel.isHidden = false
            alertView?.messageLabel.text = "Sign up was successful. Please login."
            alertView?.alertTextField.isHidden = true
            alertView?.actionButton.setTitle("Login", for: .normal)
        }
        
        if let keyWindow,
           let alertView {
            keyWindow.addSubview(alertView)
        }
    }
    
    func removeFromSuperview() {
        self.alertView?.removeFromSuperview()
        self.alertView = nil
    }
}
