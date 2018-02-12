//
//  Utilities.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

protocol Nameable {}

extension Nameable {
    static var name: String {
        return String(describing: self)
    }
}

protocol NibGettable: Nameable {}
extension NibGettable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: nil)
    }
}

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

struct ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    static var cached: [String: UIImage] = [:]
    
    static func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        func ignore(_ error: Error) {}
        
        if let cachedImage = cached[url] {
            completion(cachedImage)
            return
        }

        let request = Request(url: url, method: .GET)
        request?.start(success: {
            let image = UIImage(data: $0)
            
            if image != nil {
                cached[url] = image!
            }
            
            asyncMain { completion(image) }
        }, failure: ignore(_:))
        
    }
    
}

