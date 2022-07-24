//
//  ComicDetailsViewModel.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class ComicDetailsViewModel: BaseViewModel {

    var comic: Comic!
    
    var didChangeFavoriteState: ((_ image: UIImage?) -> Void)?
    
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
    
    var favoriteImage: UIImage? {
        comic.isSaved ? UIImage(named: "heart-filled") : UIImage(named: "heart")
    }
    
    func handleFavorite() {
        if comic.isSaved {
            // Delete
            let rows = Comic.rows(filter: "num == \(comic.num)")
            if let row = rows.first {
                let success = row.delete(force: true)
                comic.isSaved = false
                Debug.log("Comic is deleted with success: \(success)")
            }
        } else {
            // Save
            comic.isSaved = true
            let success = comic.save()
            Debug.log("Comic saved with success: \(success)")
        }
        didChangeFavoriteState?(favoriteImage)
        NotificationCenter.default.post(name: .favoriteListChanged, object: nil)
    }
}
