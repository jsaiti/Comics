//
//  CellIdentifiable.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

protocol CellIdentifiable {
    static var nib: UINib { get }
    static var identifier: String { get }
}

extension CellIdentifiable {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
