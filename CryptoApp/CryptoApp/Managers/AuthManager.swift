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
    
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        ActivityIndicatorManager.shared.startActivity()
        auth.signIn(withEmail: email, password: password) { (result, error)  in
            ActivityIndicatorManager.shared.endActivity()
            if let error {
                print(error)
                completion(.failure(.loginError))
            } else {
                if (result?.user) != nil {
                    completion(.success(()))
                }
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
                completion(.success(()))
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
