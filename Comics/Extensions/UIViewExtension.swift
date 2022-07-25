//
//  UIViewExtension.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

extension UIView {

    func roundCorners(radius: CGFloat = 8, clipToBounds: Bool) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = clipToBounds
    }
    
    func addShadow(color: UIColor = .gray, shadowRadius: CGFloat = 3.0, level: CGFloat = 0.7, opacity: Float = 0.7, cornerRadius: CGFloat = 8.0) {
        self.layer.shadowColor = color.withAlphaComponent(level).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
}
