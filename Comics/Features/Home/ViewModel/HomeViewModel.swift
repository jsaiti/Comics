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
    
    private let limit: Int = 20
    private var offset: Int = 0
    private var isLoading: Bool = false
    
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
            if !isLoading {
                isLoading = true
                let startIndex = offset
                var lastIndex = offset + limit
                if lastIndex > totalComics {
                    lastIndex = totalComics
                }
                getComic(index: startIndex, limit: lastIndex)
            }
        } else {
            stopLoading?()
        }
    }
    
    private func getComic(index: Int, limit: Int) {
        getSingleComic(comicNumber: index + 1) { [weak self] comic in
            guard let strongSelf = self else { return }
            strongSelf.offset += 1
            strongSelf.items.append(comic)
            strongSelf.checkTheEnd(index: index, limit: limit)
        } onError: { [weak self] _, _ in
            guard let strongSelf = self else { return }
            strongSelf.offset += 1
            strongSelf.checkTheEnd(index: index, limit: limit)
        }
    }
    
    private func checkTheEnd(index: Int, limit: Int) {
        if index < limit - 1 {
            getComic(index: index + 1, limit: limit)
        } else {
            didLoadItems?(items)
            stopLoading?()
            isLoading = false
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
        offset = 0
        totalComics = 0
    }
}

// TableView Data
extension HomeViewModel {
    var numberOfRows: Int {
        return items.count
    }
    
    func getItemForIndex(index: Int) -> Comic? {
        items[safe: index]
    }
}
