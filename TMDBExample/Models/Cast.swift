//
//  Cast.swift
//  TMDBExample
//
//  Created by ss on 12/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    let name: String
    let character: String
    let order: Int
    private let profilePath: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CastCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        character = try container.decode(String.self, forKey: .character)
        order = try container.decode(Int.self, forKey: .order)
        profilePath = try? container.decode(String.self, forKey: .profilePath)
    }
    
    func profileImagePath(imageWidth: Int) -> String {
        guard let profilePath = profilePath else { return ""}
        return Path.imagePath(imageWidth: imageWidth, filePath: profilePath)
    }
    
    private enum CastCodingKeys: String, CodingKey {
        case name
        case character
        case order
        case profilePath = "profile_path"
    }
}
