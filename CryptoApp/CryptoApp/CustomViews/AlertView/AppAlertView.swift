//
//  AppAlertView.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

final class AppAlertView: UIView, CustomViewProtocol {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var alertTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(for: "AppAlertView")
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(for: "AppAlertView")
    }
    
    private func configure() {
        alertTextField.isHidden = true
        self.backView.backgroundColor = .black.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
                                     self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)])
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .init(width: -4, height: 4)
    }
    
    // MARK: Actions
    @IBAction private func actionButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            if let text = self.alertTextField.text, text.count > 5 {
                AlertManager.shared.removeFromSuperview()
                AuthManager.shared.resetPassword(with: text) { results in
                    switch results {
                    case .success:
                        AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Done.", message: "Password reset mail was sent."))
                    case .failure(let error):
                        AlertManager.shared.showAlert(type: .titleMessageDismiss(title: "Fail.", message: error.localizedDescription))
                    }
                }
            } else {
                AlertManager.shared.removeFromSuperview()
            }
        }
    }
    
    @IBAction private func closeButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            AlertManager.shared.removeFromSuperview()
        }
    }
    
}
