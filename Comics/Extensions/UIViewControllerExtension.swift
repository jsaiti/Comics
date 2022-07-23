//
//  UIViewControllerExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

extension UIViewController {

    var customVisibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.customVisibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.customVisibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.customVisibleViewController
        } else if self is UIAlertController {
            return nil
        } else {
            return self
        }
    }
}
