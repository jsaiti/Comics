//
//  UILabelUtils.swift
//  Comics
//
//  Created by Jusuf Saiti on 26.7.22.
//

import UIKit

@IBDesignable class BaseLabel: UILabel {
    
    var bgColor: UIColor { return .clear }
    var txtColor: UIColor { return .black }
    var textFont: UIFont { return UIFont(.medium, size: 17) }
    var cornerRadius: CGFloat { return 0 }
    var attributes: [NSAttributedString.Key: Any]? { return nil }
    var defaultTitleInsets: UIEdgeInsets { return .zero }
    
    @IBInspectable public var textSize: CGFloat = 15 {
        willSet {
            font = UIFont(name: font.fontName, size: newValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        backgroundColor = bgColor
        textColor = txtColor
        font = textFont
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: defaultTitleInsets))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if cornerRadius > 0 {
            roundCorners(radius: cornerRadius, clipToBounds: true)
        }
    }
}

/// Large Title
class LabelLargeTitle: BaseLabel {
    override var txtColor: UIColor { return .label }
    override var textFont: UIFont { return .largeTitle }
}

/// Title
class LabelTitle: BaseLabel {
    override var txtColor: UIColor { return .label }
    override var textFont: UIFont { return .title }
}

// Body
class LabelBody: BaseLabel {
    override var txtColor: UIColor { return .label }
    override var textFont: UIFont { return .body }
}

/// H3
class LabelH3: BaseLabel {
    override var txtColor: UIColor { return .label }
    override var textFont: UIFont { return .h3 }
}
