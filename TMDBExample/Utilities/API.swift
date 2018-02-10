//
//  API.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct API {
    
    static func getMovie() {
        
        guard let d = Path.servicePath(path: "movie/330459", items: [:]) else { return }

        let request = Request(url: d, method: .GET)
        
        request?.start(success: {
            let movie = try? JSONDecoder().decode(Movie.self, from: $0)
            
            
        }, failure: { error in
            print(error)
            print(error)
        })
    }
    
    
}
