//
//  Router.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

protocol Router: URLRequestConvertible {
  var path: String { get }
  var requiresAuth: Bool { get }
  var params: Parameters? { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
}

extension Router {
  func asURLRequest() throws -> URLRequest {
    return try BaseRouterManager.buildRequest(self)
  }
  var requiresAuth: Bool { return true }
  var headers: [String: String]? { return nil }
}
