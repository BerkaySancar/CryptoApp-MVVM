//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navController)
        appCoordinator?.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard let window = window else {
            return
        }
        
        if animated {
            UIView.transition(
                with: window,
                duration: 0.5,
                options: [.transitionCrossDissolve],
                animations: nil,
                completion: nil
            )
        }
        
        window.rootViewController = viewController
    }
}

