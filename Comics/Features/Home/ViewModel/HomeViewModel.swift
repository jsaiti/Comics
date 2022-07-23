//
//  HomeViewModel.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    
    var startLoading: (() -> Void)?
    var stopLoading: (() -> Void)?
    
    func getSingleComic(comicNumber: Int) {
        startLoading?()
        APIManager.shared.getSingleComic(comicNumber: comicNumber) { [weak self] comic in
            self?.stopLoading?()
            print(comic)
        } onError: { [weak self] _, error in
            self?.stopLoading?()
        }
    }
}
