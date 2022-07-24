//
//  ComicTableViewCellViewModel.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class ComicTableViewCellViewModel {
    
    var comic: Comic!
    
    var imageUrl: String {
        comic.img
    }
    
    var comicNumber: String {
        "Comic #\(comic.num)"
    }
     
    var title: String {
        comic.safeTitle
    }
    
    var date: String {
        comic.day + "." + comic.month + "." + comic.year
    }
    
    init(comic: Comic) {
        self.comic = comic
    }
}
