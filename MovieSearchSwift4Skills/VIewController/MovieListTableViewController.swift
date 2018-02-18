//
//  MovieListTableViewController.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit
import SafariServices

class MovieListTableViewController: UITableViewController, UISearchBarDelegate, MovieTableViewCellDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.prefetchDataSource = self
    }
    
    // MARK: - Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        MovieController.shared.fetchMovie(with: searchText) { (moives, error) in
            DispatchQueue.main.async { [weak self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self?.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func isLikedButtonCellTapped(_ cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let moive = MovieController.shared.movies[indexPath.row]
        let _ = MovieController.shared.updateLikedImage(movie: moive)
        tableView.reloadRows(at: [indexPath], with: .fade)
        cell.updateViews()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MovieController.shared.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellID, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let moive = MovieController.shared.movies[indexPath.row]
        guard let posterPath = moive.posterPath else { return UITableViewCell() }
        
        cell.movie = moive
        cell.delegate = self 
        cell.posterImageView.loadImage(imagePath: posterPath)

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoiveDetail" {
            guard let destinationVC = segue.destination as? MovieDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
         
            let movie = MovieController.shared.movies[indexPath.row]
            
            destinationVC.movie = movie
           
            
        }
    }

}

extension MovieListTableViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            let moive = MovieController.shared.movies[indexPath.row]
            let baseImageUrl = URL(string: "\(Query.shared.imageBaseUrl)")
            guard let posterUrl = moive.posterPath,
            let requestUrl = baseImageUrl?.appendingPathComponent(posterUrl) else { return }
            
            URLSession.shared.dataTask(with: requestUrl)
            print("Prefetching \(moive.title)")
        }
    }
}




