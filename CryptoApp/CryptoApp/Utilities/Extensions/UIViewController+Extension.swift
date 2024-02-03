//
//  UIViewController+Extension.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UIViewController

extension UIViewController {
    
    static func instantiateFromStoryboard(_ name: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
    private static func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}
