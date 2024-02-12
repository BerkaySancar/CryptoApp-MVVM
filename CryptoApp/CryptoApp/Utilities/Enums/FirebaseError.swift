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
    case emailNotVerified
    case sendEmailVerificationError

    var errorDescription: String {
        switch self {
        case .loginError:
            return "Login failed. Try again."
        case .signUpError:
            return "Something went wrong. Try again."
        case .signOutError:
            return "Sign out failed. Try again."
        case .passwordResetError:
            return "Email not found."
        case .emailNotVerified:
            return "Email not verified!"
        case .sendEmailVerificationError:
            return "Unable to send authentication email."
        }
    }
}
