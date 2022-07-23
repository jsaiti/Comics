//
//  StringExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
