//
//  ViewModelViewController.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

class ViewModelViewController<T: BaseViewModel>: BaseViewController {

    var viewModel: T

    init(viewModel: T, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = T()
        super.init(coder: coder)
    }
}
