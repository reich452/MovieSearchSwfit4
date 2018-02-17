//
//  Movie.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    // MARK: - JSONProperties
    let title: String
    let popularity: Double
    let posterPath: String?
    let overview: String
    let id: Int
    
    // MARK: - Properties
    var isLiked: Bool = false 
    
    private enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case posterPath = "poster_path"
        case overview
        case id
    }
}
