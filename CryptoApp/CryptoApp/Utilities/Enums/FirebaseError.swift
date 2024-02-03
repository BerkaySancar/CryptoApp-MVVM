//
//  FirebaseError.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

enum FirebaseError: Error {
    case loginError
    case signUpError
    case signOutError
    case passwordResetError

    var localizedDescription: String {
        switch self {
        case .loginError:
            return NSLocalizedString("Login failed. Try again.", comment: "")
        case .signUpError:
            return NSLocalizedString("Something went wrong. Try again.", comment: "")
        case .signOutError:
            return NSLocalizedString("Sign out failed. Try again.", comment: "")
        case .passwordResetError:
            return NSLocalizedString("Email not found.", comment: "")
        }
    }
}
