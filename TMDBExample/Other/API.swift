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
        let items: [String: Any] = ["sort_by": "popularity.desc"]
        getMovies(path: path, page: page, queries: items, success: success, failure: failure)
    }
    
    static func getMoviesByGenre(genreId: Int, page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "discover/movie"
        let items: [String: Any] = ["with_genres": genreId]
        getMovies(path: path, page: page, queries: items, success: success, failure: failure)
    }
    
    static func getUpcoming(page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "movie/upcoming"
        getMovies(path: path, page: page, success: success, failure: failure)
    }
    
    static func getSimilar(movieId: Int, page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "movie/\(movieId)/similar"
        getMovies(path: path, page: page, success: success, failure: failure)
    }
    
    static func searchMovies(query: String, page: Int, success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        let path = "search/movie"
        let query: [String: Any] = ["query": query]
        getMovies(path: path, page: page, queries: query, success: success, failure: failure)
    }
    
    static func getMovies(path: String,
                          page: Int,
                          queries: [String: Any]? = nil,
                          success: @escaping ([Movie]) -> Void,
                          failure: @escaping (Error) -> Void) {
        var queryItems: [String: Any] = ["page": page]
        queries?.forEach {
            queryItems[$0.key] = $0.value
        }
        
        let urlStr = Path.servicePath(path: path, items: queryItems)
        let request = Request(url: urlStr, method: .GET)
        request?.start(success: { data in
            let result = try? JSONDecoder().decode(MoviesResponseContainer.self, from: data)
            asyncMain {
                success(result?.results ?? [])
            }
        }, failure: { error in
            asyncMain { failure(error) }
        })
    }
    
    static func getGenres(success: @escaping ([Genre]) -> Void, failure: @escaping (Error) -> Void) {
        let urlStr = Path.servicePath(path: "genre/movie/list", items: [:])
        let request = Request(url: urlStr, method: .GET)
        request?.start(success: {
            let result = try? JSONDecoder().decode(GenresResponseContainer.self, from: $0)
            asyncMain {
                success(result?.genres ?? [])
            }
        }, failure: { error in
            failure(error)
        })
    }
    
    
    static func getCast(movieId: Int, success: @escaping ([Cast]) -> Void, failure: @escaping (Error) -> Void) {
        let urlStr = Path.servicePath(path: "movie/\(movieId)/credits", items: [:])
        let request = Request(url: urlStr, method: .GET)
        request?.start(success: {
            let result = try? JSONDecoder().decode(CastResponseContainer.self, from: $0)
            asyncMain {
                success(result?.cast ?? [])
            }
        }, failure: { error in
            failure(error)
        })
    }
    
}

private struct GenresResponseContainer: Decodable {
    let genres: [Genre]
}

private struct MoviesResponseContainer: Decodable {
    let page: Int
    let results: [Movie]
}

private struct CastResponseContainer: Decodable {
    let cast: [Cast]
}
