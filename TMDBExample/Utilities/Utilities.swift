//
//  Utilities.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct Path {
    static func imagePath(imageWidth: Int = Constant.defaultImageWidth, filePath: String) -> String {
        return Constant.cdnBaseUrl + "w\(imageWidth)" + filePath
    }
    
    static func servicePath(path: String, items: [String: String]) -> String? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constant.baseUrl
        components.path = "/\(Constant.apiVersion)/" + path
        components.queryItems = items.flatMap { URLQueryItem(name: $0.key, value: $0.value) }
        let apiQuery = URLQueryItem(name: "api_key", value: Constant.apiKey)
        components.queryItems?.append(apiQuery)
        return components.url?.absoluteString
    }
}

struct Formatter {
    
    static let defaultDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
}

func asyncMain(cl: @escaping () -> Void) {
    DispatchQueue.main.async {
        cl()
    }
}

func asyncGlobal(cl: @escaping () -> Void) {
    DispatchQueue.global().async {
        cl()
    }
}

