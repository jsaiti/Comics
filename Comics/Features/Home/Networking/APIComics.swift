//
//  APIComics.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

extension APIManager {
    
    typealias GetSingleComic = (_ comic: Comic) -> Void
    
    func getSingleComic(comicNumber: Int, onSuccess: @escaping GetSingleComic, onError: @escaping ErrorHandler) {
        let router = ComicsRouter.getSingleComic(comicNumber: comicNumber)
        request(router, onSuccess: onSuccess, onError: onError)
    }
}
