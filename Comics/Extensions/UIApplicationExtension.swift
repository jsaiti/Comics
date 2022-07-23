//
//  UIApplicationExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

extension UIApplication {
    /// The top most view controller
    static var topMostViewController: UIViewController? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.customVisibleViewController
    }
}
