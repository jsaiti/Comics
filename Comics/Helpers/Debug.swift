//
//  Debug.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

class Debug: NSObject {
    class func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        Swift.print(items[0], separator: separator, terminator: terminator)
        #endif
    }
}
