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
    var didLoadItems: ((_ items: [Comic]) -> Void)?
    
    var items = [Comic]()
    var totalComics: Int = 0
    
    private let limit: Int = 25
    private var offset: Int = 1
    
    func loadData() {
        resetData()
        startLoading?()
        getLastComic { [weak self] comic in
            self?.totalComics = comic.num
            self?.getComics()
        } onError: { [weak self] _, _ in
            self?.stopLoading?()
        }
    }
    
    func getComics() {
        if offset < totalComics {
            let startIndex = offset
            var lastIndex = offset + limit
            if lastIndex > totalComics {
                lastIndex = totalComics
            }
            for index in startIndex...lastIndex {
                getSingleComic(comicNumber: index) { [weak self] comic in
                    guard let strongSelf = self else {
                        return
                    }
                    strongSelf.offset += 1
                    strongSelf.items.append(comic)
                    if strongSelf.offset == lastIndex {
                        strongSelf.didLoadItems?(strongSelf.items)
                        strongSelf.stopLoading?()
                    }
                } onError: { [weak self] _, _ in
                    self?.offset += 1
                }
            }
        } else {
            stopLoading?()
        }
    }
    
    func getSingleComic(comicNumber: Int, onSuccess: @escaping APIManager.GetSingleComic, onError: @escaping ErrorHandler) {
        APIManager.shared.getSingleComic(comicNumber: comicNumber, onSuccess: onSuccess, onError: onError)
    }
    
    private func getLastComic(onSuccess: @escaping APIManager.GetSingleComic, onError: @escaping ErrorHandler) {
        APIManager.shared.getLastComic(onSuccess: onSuccess, onError: onError)
    }
    
    private func resetData() {
        items.removeAll()
        offset = 1
        totalComics = 0
    }
}
