//
//  NetworkManager.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit

typealias ErrorHandler = (ErrorResponse?, Error?) -> Void
typealias Parameters = [String: Any]

class APIManager: NSObject {

    static let shared = APIManager()
    
    func request<T: Decodable>(_ router: Router, onSuccess:  @escaping (T) -> Void, onError: @escaping ErrorHandler) {
        do {
            let urlRequest = try router.asURLRequest()
            nativeRequest(urlRequest) { data in
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        onSuccess(object)
                    }
                } catch {
                    print("Failed to serialize JSON: ", error)
                    onError(nil, error)
                }
            } onError: { error in
                onError(nil, error)
            }
        } catch {
            print("Failed to serialize request: ", error)
            onError(nil, error)
        }
    }
    
    private func nativeRequest(_ request: URLRequest, onSuccess: @escaping (_ data: Data) -> Void, onError: @escaping (_ error: Error?) -> Void) {
        
        guard let url = request.url else {
            onError(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                onError(error)
                return
            }
            
            if let data = data {
                onSuccess(data)
            } else {
                onError(nil)
            }
        }.resume()
    }
}
