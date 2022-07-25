//
//  Comic.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

class Comic: SQLTable, Codable {
    var id = -1
    var month: String
    var num: Int
    var link, year, news, safeTitle: String
    var transcript, alt: String
    var img: String
    var title, day: String
    var isSaved = false
    var imageData = Data()

    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
}
