//
//  Query.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

struct Query {
    static let shared = Query()
    
    static private let apiKey = "3e6fc78d34ea9b6595d61441a091daf9"
    static private let baseURL = "https://api.themoviedb.org/3/search/movie?"
    static private let queryParam = "query"
    static private let apiParam = "api_key"
    static private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
}
