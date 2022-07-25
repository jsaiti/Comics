//
//  ErrorResponse.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

struct ErrorResponse: Codable {
  var message: String?
  var code: Int?
  var error: String?
}
