//
//  ImageManager.swift
//  TMDBExample
//
//  Created by ss on 14/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

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
