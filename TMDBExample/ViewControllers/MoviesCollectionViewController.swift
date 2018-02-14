//
//  MoviesCollectionViewController.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class MoviesCollectionViewController: UICollectionViewController {
    
    private var movies: [Movie] = []
    var moviesFetcher: Fetcher<Movie>!
    
    init(collectionViewLayout: UICollectionViewLayout = FlowLayouts.moviewCollectionLayout, moviesFetcher: Fetcher<Movie>) {
        self.moviesFetcher = moviesFetcher
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(collectionViewLayout: FlowLayouts.moviewCollectionLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.name)
        collectionView?.backgroundColor = .white
        collectionView?.keyboardDismissMode = .onDrag
        fetchMovies()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.name, for: indexPath) as! MovieCollectionViewCell
        let urlStr = movies[indexPath.row].posterPath(withWidth: Constant.defaultImageWidth)
        
        ImageManager.getImage(url: urlStr) {
            cell.posterImageView.image = $0
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieVc = MovieViewController(movie: movie)
        navigationController?.pushViewController(movieVc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > movies.count - 2 {
            fetchMovies()
        }
    }
    
    private func fetchMovies() {
        moviesFetcher.fetch { newMoviesData in
            self.movies += newMoviesData
            self.collectionView?.reloadData()
        }
    }
}
