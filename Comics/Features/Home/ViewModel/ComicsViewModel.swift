//
//  ComicsViewModel.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

class ComicsViewModel: BaseViewModel {
    
    var startLoading: (() -> Void)?
    var stopLoading: (() -> Void)?
    var didLoadItems: (() -> Void)?
    
    var items = [Comic]()
    var savedItems = [Comic]()
    var totalComics: Int = 0
    
    var useSavedComics: Bool = false {
        didSet {
            didLoadItems?()
        }
    }
    
    private let limit: Int = 20
    private var offset: Int = 0
    private var isLoading: Bool = false
    
    required init() {
        super.init()
        self.addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    func loadData() {
        resetData()
        startLoading?()
        getSavedComics()
        getLastComic { [weak self] comic in
            self?.totalComics = comic.num
            self?.getComics()
        } onError: { [weak self] _, _ in
            self?.stopLoading?()
        }
    }
    
    func getComics() {
        if !useSavedComics {
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
            didLoadItems?()
            stopLoading?()
            isLoading = false
            handleSavedComics()
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
    
    private func getSavedComics() {
        savedItems = Comic.rows()
    }
    
    private func handleSavedComics() {
        getSavedComics()
        if !savedItems.isEmpty {
            items.forEach { comic in
                if let _ = savedItems.first(where: {$0.num == comic.num}) {
                    comic.isSaved = true
                }
            }
        }
    }
}

// TableView Data
extension ComicsViewModel {
    var numberOfRows: Int {
        if useSavedComics {
            return savedItems.count
        }
        return items.count
    }
    
    func getItemForIndex(index: Int) -> Comic? {
        if useSavedComics {
            return savedItems[safe: index]
        }
       return items[safe: index]
    }
}

extension ComicsViewModel {
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteListChanged), name: .favoriteListChanged, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func favoriteListChanged() {
        getSavedComics()
        if useSavedComics {
            didLoadItems?()
        }
    }
}
