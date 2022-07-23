//
//  HomeViewController.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

class HomeViewController: ViewModelViewController<HomeViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        addListeners()
        viewModel.getSingleComic(comicNumber: 600)
    }
    
    private func addListeners() {
        viewModel.startLoading = { [weak self] in
            self?.showProgress()
        }
        
        viewModel.startLoading = { [weak self] in
            self?.dismissProgress()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
