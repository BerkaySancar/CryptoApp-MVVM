//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit
import FirebaseCore
import IQKeyboardManagerSwift

//Global
var keyWindow: UIWindow? {
    let allScenes = UIApplication.shared.connectedScenes
    for scene in allScenes {
      guard let windowScene = scene as? UIWindowScene else { continue }
      for window in windowScene.windows where window.isKeyWindow {
         return window
       }
     }
      return nil
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: Coordinator?
    
    override init() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navController)
        appCoordinator?.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
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

