//
//  Moview.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let releaseDate: Date?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        
        let date = try container.decode(String.self, forKey: .releaseDate)
        releaseDate = Formatter.defaultDateFormatter.date(from: date)
        
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        self.posterPath = Path.imagePath(filePath: posterPath)
        
        let backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.backdropPath = Path.imagePath(filePath: backdropPath)
    }
    
    enum MovieCodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case id
        case title
        case overview
        case runtime
        
    }
}
