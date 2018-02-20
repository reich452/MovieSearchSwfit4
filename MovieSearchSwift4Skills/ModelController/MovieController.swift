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
    var movie: Movie?
    var movies = [Movie]()
    var likedMovies: [Movie] = []
    
    var likedMovieIDs: [Int] {
        get {
            return likedMovies.flatMap({$0.id})
        }
        set {
            guard let movie = movie else { return }
            likedMovies.append(movie)
        }
    }
    
    init() {
        likedMovies = load()
    }

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
    
    // C
    
    func saveLikedMovie(movieId: Int, isLiked: Bool = false) {
        let movie = Movie(id: movieId, isLiked: isLiked)
        likedMovies.append(movie)
        save()
    }
    
    func deleteLikedMovie(movie: Movie) {
   
        guard let indexAt = likedMovies.index(where: {$0.id == movie.id }) else { return }
        likedMovies.remove(at: indexAt)
    
        save()
    }
 
    // U
    @discardableResult
    func updateLikedImage(movie: Movie) -> Movie?  {
    
        movie.isLiked = !movie.isLiked
        guard let index = likedMovies.index(of: movie) else { return nil }
        save()
        return likedMovies[index]
    }
    
    
    // R
   private func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filePath = "likedMovies.json"
        let url = documentDirectory.appendingPathComponent(filePath)
        return url
    }
    
    // MARK: - Save & Load
    
  private func save() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(likedMovies)
            try data.write(to: fileURL())
            
        } catch let error {
            print("Error saving: \(#function) \(error) \(error.localizedDescription)")
        }
    }
    
    func load() -> [Movie] {
        
        do {
            let data = try Data(contentsOf: fileURL())
            
            let movies = try JSONDecoder().decode([Movie].self, from: data).removeDuplicates()
            print(movies.flatMap{$0.id})
            return movies
        } catch let error {
            print("Error loading liked movies from disk: \(#function) \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    func remove() {
        let url = fileURL()
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("Error removing file: \(#function) \(error.localizedDescription) \(error)")
            }
        }
    }
}



