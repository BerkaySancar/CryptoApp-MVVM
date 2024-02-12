//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import FirebaseCore
import FirebaseAuth
import IQKeyboardManagerSwift
import UIKit

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
        
        //MARK: Third Party Starters
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        //MARK: Window settings
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navController)
        let isLoggedIn = Auth.auth().currentUser != nil && Auth.auth().currentUser?.isEmailVerified == true
        appCoordinator?.start(isLoggedIn: isLoggedIn)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        //MARK: Appearance Configuration
        configureNavBarAppearance()
        tabBarAppearance()
        
        return true
    }
    
    private func configureNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBackground.withAlphaComponent(0.75)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.appYellow]
        UIBarButtonItem.appearance().tintColor = UIColor.appYellow
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    private func tabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .appBackground.withAlphaComponent(0.90)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}

