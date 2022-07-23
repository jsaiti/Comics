//
//  ComicsRouter.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

enum ComicsRouter: Router {
    
    case getSingleComic(comicNumber: Int)
    
    var path: String {
        switch self {
        case .getSingleComic(let comicNumber):
            return "\(comicNumber)/info.0.json"
        }
    }
    
    var params: Parameters? {
        return nil
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSingleComic:
            return .get
        }
    }
}
