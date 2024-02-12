//
//  AuthManager.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation

import Foundation
import FirebaseAuth
import FirebaseCore

protocol AuthManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func resetPassword(with email: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func signOut(completion: (Result<Void, FirebaseError>) -> Void)
}

final class AuthManager: AuthManagerProtocol {
    
    private let auth = Auth.auth()
    
    func login(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        ActivityIndicatorManager.shared.startActivity()
        auth.signIn(withEmail: email, password: password) { (result, error)  in
            ActivityIndicatorManager.shared.endActivity()
            if let result {
                if result.user.isEmailVerified {
                    completion(.success(()))
                } else {
                    completion(.failure(.emailNotVerified))
                }
            }
            if let error {
                print(error.localizedDescription)
                completion(.failure(.loginError))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        ActivityIndicatorManager.shared.startActivity()
        auth.createUser(withEmail: email, password: password) { (result, error) in
            ActivityIndicatorManager.shared.endActivity()
            if let error {
                print(error)
                completion(.failure(.signUpError))
            } else {
                result?.user.sendEmailVerification { error in
                    if let error {
                        debugPrint(error)
                        completion(.failure(.sendEmailVerificationError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func resetPassword(with email: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        ActivityIndicatorManager.shared.startActivity()
        auth.sendPasswordReset(withEmail: email) { error in
            ActivityIndicatorManager.shared.endActivity()
            if let error {
                print(error)
                completion(.failure(.passwordResetError))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signOut(completion: (Result<Void, FirebaseError>) -> Void) {
        ActivityIndicatorManager.shared.startActivity()
        do {
            try auth.signOut()
            completion(.success(()))
            ActivityIndicatorManager.shared.endActivity()
        } catch {
            completion(.failure(.signOutError))
            ActivityIndicatorManager.shared.endActivity()
        }
    }
}
