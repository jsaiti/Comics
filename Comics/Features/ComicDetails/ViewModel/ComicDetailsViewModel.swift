//
//  ComicDetailsViewModel.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class ComicDetailsViewModel: BaseViewModel {

    
    var comic: Comic!
    
    var navigationTitle: String {
        "Comic #\(comic.num)"
    }
    
    var title: String {
        comic.safeTitle
    }
    
    var imageURL: String {
        comic.img
    }
    
    var date: String {
        comic.day + "." + comic.month + "." + comic.year
    }
    
    var description: String {
        comic.transcript
    }
    
    var explanation: String {
        comic.alt
    }
    
    var shareInformation: String {
        title + "\n" + description
    }
}
