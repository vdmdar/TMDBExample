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
    let releaseDate: Date?
    private let posterPath: String
    private let backdropPath: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        
        let date = try container.decode(String.self, forKey: .releaseDate)
        releaseDate = Formatter.defaultDateFormatter.date(from: date)
        
        posterPath = try container.decode(String.self, forKey: .posterPath)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)    }
    
    func posterPath(withWidth width: Int) -> String {
        return Path.imagePath(imageWidth: width, filePath: posterPath)
    }
    
    func backdropPath(withWidth width: Int) -> String {
        return Path.imagePath(imageWidth: width, filePath: backdropPath)
    }
    
    private enum MovieCodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case id
        case title
        case overview
        case runtime
        
    }
}
