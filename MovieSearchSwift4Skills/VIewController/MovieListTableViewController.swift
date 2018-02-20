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
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        let _ = MovieController.shared.load()
        MovieController.shared.fetchMovie(with: searchText) { (movies, error) in
            DispatchQueue.main.async { [weak self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self?.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    func isLikedButtonCellTapped(_ cell: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let movie = MovieController.shared.movies[indexPath.row]
        MovieController.shared.updateLikedImage(movie: movie)
    
        if MovieController.shared.likedMovieIDs.contains(movie.id) {
            MovieController.shared.deleteLikedMovie(movie: movie)
            cell.likeButton.setImage(#imageLiteral(resourceName: "emptyHeart"), for: .normal)
        } else {
            MovieController.shared.saveLikedMovie(movieId: movie.id)
        }
    
        tableView.reloadRows(at: [indexPath], with: .fade)
        cell.updateViews()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MovieController.shared.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellID, for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = MovieController.shared.movies[indexPath.row]
        guard let posterPath = movie.posterPath else { return UITableViewCell() }

        cell.movie = movie
        cell.delegate = self 
        cell.posterImageView.loadImage(imagePath: posterPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let moiveCell = cell as? MovieTableViewCell else { return }
        
        moiveCell.backgroundColor = UIColor(white: 1, alpha: 0.0)
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
        }
    }
}

extension MovieListTableViewController {
    
    func setUpUI() {
        let backgroundImage = #imageLiteral(resourceName: "moiveCellBackground")
        
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFit
        
        tableView.backgroundView = imageView
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
    }
}




