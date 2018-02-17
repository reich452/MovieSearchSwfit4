//
//  MovieListTableViewController.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }
    
    // MARK: - Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        MovieController.shared.fetchMovie(with: searchText) { (moives, error) in
            DispatchQueue.main.async { [weak self] in
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self?.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MovieController.shared.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellID, for: indexPath)
        
        let moive = MovieController.shared.movies[indexPath.row]
        
        cell.textLabel?.text = moive.title
        cell.detailTextLabel?.text = moive.overview
        
        return cell
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }



}
