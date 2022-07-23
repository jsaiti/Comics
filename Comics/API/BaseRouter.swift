//
//  BaseRouter.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import Foundation

class BaseRouterManager {
    
    static let baseURL = ""
    
    // MARK: - RouterManager
    static func buildRequest(_ router: Router) throws -> URLRequest {
        let url = URL(string: baseURL + router.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        router.headers?.enumerated().forEach {
            urlRequest.setValue($0.element.value, forHTTPHeaderField: $0.element.key)
        }
        if let arrayParams = router.params?[""] as? [Parameters] {
            if let paramData = encodeParameters(params: arrayParams) {
                urlRequest.httpBody = paramData
            }
        }
        return urlRequest
    }
    
    private static func encodeParameters(params: [Parameters]) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: [])
            return data
        } catch {
            print(error)
        }
        return nil
    }
}
