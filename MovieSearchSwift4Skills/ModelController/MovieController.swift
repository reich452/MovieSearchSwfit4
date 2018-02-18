//
//  MovieController.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

class MovieController {
    
    static let shared = MovieController()
    
    // MARK: - Private
    
    private let baseUrl = URL(string: "https://api.themoviedb.org/3/search/movie?")!
    private let baseUrlString = "https://image.tmdb.org/t/p/w500/"
    private let apiKey = "3e6fc78d34ea9b6595d61441a091daf9"
    
    // MARK: - Properties
    var movies = [Movie]()

    // MARK: - Fetch
    typealias FetchMovieCompletionHandeler = ([Movie]?, MovieError?) -> Void
    
    func fetchMovie(with searchTerm: String, completion: @escaping FetchMovieCompletionHandeler) {
        let queryItems = ["query" : "\(searchTerm)", "api_key" : apiKey]
        let requestURL = url(byAdding: queryItems, to: baseUrl)
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            do {
                
                if let error = error { throw error }
                
                guard let data = data else { throw NSError() }
                
                let movies = try JSONDecoder().decode(Movies.self, from: data).results
                self.movies = movies
                
                completion(movies, nil)
                
            } catch let error {
                print("Error fetching movie: \(error) \(error.localizedDescription) \(#function)")
                completion(nil, .jsonConversionFailure)
            }
        }.resume()
    }
    
    func url(byAdding parameters: [String : String]?,
                    to url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap({ URLQueryItem(name: $0.0, value: $0.1) })
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        return url
    }
    
    // MARK: - CRUD
    
    func updateLikedImage(movie: Movie) -> Movie? {
    
        movie.isLiked = !movie.isLiked
        guard let index = movies.index(of: movie) else { return nil }
        return movies[index]
    }
    
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
}


