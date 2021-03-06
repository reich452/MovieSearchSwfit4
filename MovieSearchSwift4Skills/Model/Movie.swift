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

class Movie: Codable {
    
    // MARK: - JSONProperties
    var title: String = ""
    var popularity: Double = 0.0
    var posterPath: String? = ""
    var overview: String = ""
    var voteAverage: Double = 0.0
    var releaseDate: String = ""
    let id: Int
    
    // MARK: - Properties
    var isLiked: Bool = false
    
    
    private enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case posterPath = "poster_path"
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case id
    }
    
    init(title: String = String(), popularity: Double = Double(), posterPath: String?, overview: String = String(), id: Int, isLiked: Bool = false, voteAverage: Double, releaseDate: String = String()) {
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.overview = overview
        self.id = id
        self.isLiked = isLiked
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
    }
}

extension Movie: Equatable {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title
        && lhs.popularity == rhs.popularity
        && lhs.posterPath == rhs.posterPath
        && lhs.overview == rhs.overview
        && lhs.id == rhs.id
        && lhs.isLiked == rhs.isLiked
        && lhs.voteAverage == rhs.voteAverage
        && rhs.releaseDate == rhs.releaseDate
    }
}



