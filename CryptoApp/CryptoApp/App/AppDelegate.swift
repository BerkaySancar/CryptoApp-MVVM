//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import UIKit
import FirebaseCore
import IQKeyboardManagerSwift

//Global keyWindow variable
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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Window settings
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navController)
        appCoordinator?.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        //Dependencies
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        //Configuration
        configureNavBarAppearance()
        
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
    
    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBackground.withAlphaComponent(0.5)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}

