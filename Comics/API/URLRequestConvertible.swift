//
//  URLRequestConvertible.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

/// Types adopting the `URLRequestConvertible` protocol can be used to safely construct `URLRequest`s.
public protocol URLRequestConvertible {
    /// Returns a `URLRequest` or throws if an `Error` was encountered.
    ///
    /// - Returns: A `URLRequest`.
    /// - Throws:  Any error thrown while constructing the `URLRequest`.
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    /// The `URLRequest` returned by discarding any `Error` encountered.
    public var urlRequest: URLRequest? { try? asURLRequest() }
}
