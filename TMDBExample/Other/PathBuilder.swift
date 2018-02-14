//
//  PathBuilder.swift
//  TMDBExample
//
//  Created by ss on 14/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct Path {
    static func imagePath(imageWidth: Int, filePath: String) -> String {
        return Constant.cdnBaseUrl + "w\(imageWidth)" + filePath
    }
    
    static func servicePath(path: String, items: [String: Any]) -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constant.baseUrl
        components.path = "/\(Constant.apiVersion)/" + path
        components.queryItems = items.flatMap { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        let apiQuery = URLQueryItem(name: "api_key", value: Constant.apiKey)
        components.queryItems?.append(apiQuery)
        return components.url?.absoluteString ?? ""
    }
}
