//
//  Request.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct Request {
    
    enum RequestError: Error {
        case invalidStatusCode, noData
    }
    
    enum HTTPMethod: String {
        case GET, POST
    }
    
    private let request: URLRequest
    
    init?(url: String, method: HTTPMethod, parameters: [String: Any]? = nil) {
        
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            let body = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = body
        }

        self.request = request
    }
    
    func start(success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) {
            if let error = self.validateResponse(data: $0, response: $1, error: $2) {
                failure(error)
                return
            }
            
            success($0!)
        }
        
        dataTask.resume()
    }
    
    private func validateResponse(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        if error != nil {
            return error
        }
        
        if data == nil {
            return RequestError.noData
        }
        
        let response = response as! HTTPURLResponse
        if !(200...299 ~= response.statusCode) {
            return RequestError.invalidStatusCode
        }
        
        return nil
    }
}
