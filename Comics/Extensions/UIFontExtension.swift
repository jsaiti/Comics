//
//  UIFontExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 26.7.22.
//

import UIKit

extension UIFont {
    enum Avenir: String {
        case medium = "Avenir-Medium"
        case heavy = "Avenir-Heavy"
        case black = "Avenir-Black"
    }
    
    convenience init(_ font: Avenir, size: CGFloat) {
        self.init(name: font.rawValue, size: size)!
    }
    
    class var largeTitle: UIFont {
        return UIFont(.black, size: 22)
    }
    
    class var title: UIFont {
        return UIFont(.heavy, size: 17)
    }
    
    class var body: UIFont {
        return UIFont(.medium, size: 15)
    }
    
    class var h3: UIFont {
        return UIFont(.medium, size: 12)
    }
}
