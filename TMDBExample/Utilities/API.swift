//
//  API.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct API {
    
    static func getMostPopular(page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "discover/movie"
        getMovies(path: path, page: page, success: success, failure: failure)
    }
    
    static func getUpcoming(page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "movie/upcoming"
        getMovies(path: path, page: page, success: success, failure: failure)
    }
    
    static func getMovies(path: String, page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let queryItems: [String: Any] = ["page": page]
        let urlStr = Path.servicePath(path: path, items: queryItems)
        let request = Request(url: urlStr, method: .GET)
        request?.start(success: { data in
            let result = try? JSONDecoder().decode(ResponsedData.self, from: data)
            asyncMain {
                success(result?.results ?? [])
            }
        }, failure: { error in
            asyncMain { failure(error) }
        })
        
    }
}

private struct ResponsedData: Decodable {
    let page: Int
    let results: [Movie]
}
