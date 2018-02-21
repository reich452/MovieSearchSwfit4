//
//  SavedMoiveCollectionViewCell.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/20/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class SavedMoiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    var moive: Movie?
    
    var posterImage: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let posterPath = moive?.posterPath else { return }
        movieImage.loadImage(imagePath: posterPath)
    }
}
