//
//  MutableCollectionExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import Foundation

extension MutableCollection {
    // Avoid crashes while accessing the array's element
    subscript (safe index: Index) -> Iterator.Element? {
        get {
            guard startIndex <= index && index < endIndex else { return nil }
            return self[index]
        }
        set(newValue) {
            guard startIndex <= index && index < endIndex else { print("Index out of range."); return }
            guard let newValue = newValue else { print("Cannot remove out of bounds items"); return }
            self[index] = newValue
        }
    }
}
