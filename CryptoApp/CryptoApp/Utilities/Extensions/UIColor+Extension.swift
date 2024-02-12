//
//  UIColor+Extension.swift
//  CryptoApp
//
//  Created by Berkay Sancar on 3.02.2024.
//

import Foundation
import UIKit.UIColor

extension UIColor {

    var appBackground: UIColor {
        return UIColor.appBackground
    }
    
    var appYellow: UIColor {
        return UIColor.appYellow
    }
    
    var appTextFieldBackground: UIColor {
        return UIColor.textFieldBackground
    }
    
    static func generateRandomCellColor() -> UIColor {
      return UIColor(
        red: CGFloat.random(in: 0...1),
        green: CGFloat.random(in: 0...1),
        blue: CGFloat.random(in: 0...1),
        alpha: 0.3)
    }
}
