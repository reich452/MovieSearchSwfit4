//
//  SavedMovieViewController.swift
//  MovieSearchSwift4Skills
//
//  Created by Nick Reichard on 2/20/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class SavedMovieViewController: UIViewController {
    @IBOutlet weak var savedMovieCollectionView: UICollectionView!
    @IBOutlet weak var topRatedSavedMoiveImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        savedMovieCollectionView.delegate = self
        savedMovieCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedMovieCollectionView.reloadData()
    }
    
    func updateViews() {
        guard let imagePath = MovieController.shared.movie?.posterPath else { return }
       
    
    }

}

extension SavedMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieController.shared.likedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.savedMoiveCellID, for: indexPath) as? SavedMoiveCollectionViewCell else { return UICollectionViewCell() }
        
        let moive = MovieController.shared.likedMovies[indexPath.row]
        guard let posterImage = moive.posterPath else { return UICollectionViewCell() }
        cell.moive = moive
        cell.movieImage.loadImage(imagePath: posterImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // number of Col.
        let nbCol = 2
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
    }
    
}
