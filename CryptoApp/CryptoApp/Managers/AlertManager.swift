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
        DispatchQueue.main.async {
            if self.alertView == nil {
                self.alertView = AppAlertView()
            }
            
            switch type {
            case .titleMessageDismiss(let title, let message):
                self.alertView?.titleLabel.text = title
                self.alertView?.messageLabel.text = message
                self.alertView?.actionButton.setTitle("OK", for: .normal)
                self.alertView?.alertTextField.isHidden = true
                
            case .passwordReset:
                self.alertView?.titleLabel.text = "Password Reset"
                self.alertView?.messageLabel.isHidden = true
                self.alertView?.alertTextField.isHidden = false
                self.alertView?.alertTextField.placeholder = "Enter your email"
                self.alertView?.actionButton.setTitle("Reset", for: .normal)
                
            case .signUpSuccess:
                self.alertView?.titleLabel.text = "Done!"
                self.alertView?.messageLabel.isHidden = false
                self.alertView?.messageLabel.text = "Sign up was successful. Please login."
                self.alertView?.alertTextField.isHidden = true
                self.alertView?.actionButton.setTitle("Login", for: .normal)
            }
            
            if let keyWindow,
               let alertView = self.alertView {
                keyWindow.addSubview(alertView)
            }
        }
    }
    
    func removeFromSuperview() {
        self.alertView?.removeFromSuperview()
        self.alertView = nil
    }
}
