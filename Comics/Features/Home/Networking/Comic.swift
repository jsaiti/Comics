//
//  Comic.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

struct Comic: Decodable {
    let month: String
    let num: Int
    let link, year, news, safeTitle: String
    let transcript, alt: String
    let img: String
    let title, day: String

    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
}
