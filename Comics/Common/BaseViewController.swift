//
//  BaseViewController.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit
import ProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProgressHud()
    }
    
    private func setupProgressHud() {
        
    }
    
    func showProgress(with status: String? = nil) {
        ProgressHUD.show(status)
    }
    
    func dismissProgress() {
        ProgressHUD.dismiss()
    }
    
    func showSuccess(with message: String? = nil) {
        ProgressHUD.showSuccess(message)
    }

    func showError(with message: String? = nil) {
        ProgressHUD.showError(message)
    }
    
    func showAlert(title: String, message: String? = nil, buttons: [String] = [], completion: ((_ id: Int?) -> Void)? = nil) {
        Helper.showAlert(in: self, title: title, message: message, buttons: buttons, completion: completion)
    }
}
