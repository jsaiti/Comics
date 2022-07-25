//
//  Helper.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

class Helper {
    static func showAlert(in viewController: UIViewController? = nil, title: String, message: String? = nil, buttons: [String] = [], completion: ((_ id: Int?) -> Void)? = nil) {
        var localizedButtons: [String] = []
        for button in buttons {
            localizedButtons.append(button.localized)
        }
        let alert = UIAlertController(title: title.localized, message: message?.localized, preferredStyle: .alert)
        if buttons.isEmpty {
            let cancelAction = UIAlertAction(title: "OK".localized, style: .cancel) { action in
                completion?(localizedButtons.firstIndex(of: action.title ?? ""))
            }
            alert.addAction(cancelAction)
        } else {
            var index: Int = 0
            while index < buttons.count {
                if index == 0 {
                    if buttons[0] == "" {
                        index += 1
                        continue
                    }
                    let firstAction = UIAlertAction(title: buttons[index].localized, style: .cancel) { action in
                        completion?(localizedButtons.firstIndex(of: action.title ?? ""))
                    }
                    alert.addAction(firstAction)
                } else {
                    let otherAction = UIAlertAction(title: buttons[index].localized, style: .default) { action in
                        completion?(localizedButtons.firstIndex(of: action.title ?? ""))
                    }
                    alert.addAction(otherAction)
                }
                index += 1
            }
        }
        alert.view.tintColor = UIColor.primary
        if let viewController = viewController {
            viewController.present(alert, animated: true, completion: nil)
        } else {
            UIApplication.topMostViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
