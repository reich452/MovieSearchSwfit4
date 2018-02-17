//
//  MovieDetailViewController.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        let popularity = Int(movie.popularity)
        titleLabel.text = movie.title
        ratingLabel.text = howManyStars(numberOfStars: popularity)
        overViewLabel.text = movie.overview
        posterImageView.loadImage(imagePath: movie.posterPath ?? "")
    }
    
    private func howManyStars(numberOfStars: Int) -> String {
        let starString: String
        
        switch numberOfStars {
        case 1:
            starString = "⭐️"
        case 2:
            starString = "⭐️⭐️"
        case 3:
            starString = "⭐️⭐️⭐️"
        case 4:
            starString = "⭐️⭐️⭐️⭐️"
        case 5:
            starString = "⭐️⭐️⭐️⭐️⭐️"
        case 6:
            starString = "⭐️⭐️⭐️⭐️⭐️⭐️"
        case 7:
            starString = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        case 8:
            starString = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        case 9:
            starString = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        case 10:
            starString = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        default:
            starString = "Not enough ratings"
        }
        
        return starString
    }

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
}
