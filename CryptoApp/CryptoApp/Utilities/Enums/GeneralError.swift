//
//  GeneralError.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

enum GeneralError: Error {
    case invalidEmailOrPassword
    
    var localizedDescription: String {
        switch self {
        case .invalidEmailOrPassword:
            return NSLocalizedString(
                                      """
                                      1) Password length is 8.
                                      2) One alphabet in password.
                                      3) One special character in password.
                                      """,
                                      comment: ""
                                     )
        }
    }
}
