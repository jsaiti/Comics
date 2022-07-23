//
//  UIColorExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

extension UIColor {
    class var primary: UIColor {
        return UIColor(named: "main") ?? .black
    }
    
    class var accent: UIColor {
        return UIColor(named: "accent") ?? .black
    }
}
