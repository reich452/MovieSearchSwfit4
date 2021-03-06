//
//  MovieTableViewCell.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/16/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

protocol MovieTableViewCellDelegate: class {
    func isLikedButtonCellTapped(_ cell: MovieTableViewCell)
    
}

class MovieTableViewCell: UITableViewCell {


    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieCellBackgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: MovieTableViewCellDelegate?
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    var posterImage: UIImage? {
        didSet {
            guard let posterPath = movie?.posterPath else { return }
            self.posterImageView.loadImage(imagePath: posterPath)
        }
    }
    
    @IBAction func isLikedButtonTapped(_ sender: UIButton) {
        delegate?.isLikedButtonCellTapped(self)
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.popularity)"
        releaseDateLabel.text = movie.releaseDate
       
        if MovieController.shared.likedMovieIDs.contains(movie.id) {
            likeButton.setImage(#imageLiteral(resourceName: "filledHeart"), for: .normal)
        } else if !movie.isLiked {
            likeButton.setImage(#imageLiteral(resourceName: "emptyHeart"), for: .normal)
        }
    }
    
    func setUpUI() {
        movieCellBackgroundImageView.isHidden = true
        backgroundColor = .clear
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true 
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
