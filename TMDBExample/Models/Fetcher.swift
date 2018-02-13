//
//  Fetcher.swift
//  TMDBExample
//
//  Created by ss on 13/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

class Fetcher<T> {
    
    var page: Int = 1
    private var dataAvailable = true
    private var isLoading = false
    
    private var onFetch: (([T]) -> Void)? = nil
    
    func fetch(completion: @escaping ([T]) -> Void) {
        guard !isLoading && dataAvailable else { return }
        onFetch = completion
        isLoading = true
        makeRequest()
    }
    
    func handleSuccess(data: [T]) {
        if !data.isEmpty {
            onFetch?(data)
            page+=1
        } else {
            dataAvailable = false
        }
        isLoading = false
    }
    
    func handleError(_ error: Error) {
        isLoading = false
    }
    
    func makeRequest() {
        fatalError("Needs to be overriden")
    }
}

final class PopularMoviesFetcher: Fetcher<Movie> {
    override func makeRequest() {
        API.getMostPopular(page: page, success: handleSuccess, failure: handleError)
    }
}

final class ByGenreMoviesFetcher: Fetcher<Movie> {
    
    let genreId: Int
    
    init(genreId: Int) {
        self.genreId = genreId
        super.init()
    }
    
    override func makeRequest() {
        API.getMoviesByGenre(genreId: genreId, page: page, success: handleSuccess, failure: handleError)
    }
}
