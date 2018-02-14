//
//  MoviesCollectionPresenter.swift
//  TMDBExample
//
//  Created by ss on 14/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesCollectionPresenterDelegate: class {
    var movies: [Movie] { get }
    var navigationController: UINavigationController? { get }
    func fetchMovies()
}

extension MoviesCollectionPresenterDelegate {
    func fetchMovies() {}
}

final class MoviesCollectionPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

    unowned var delegate: MoviesCollectionPresenterDelegate
    
    var moviePosterWidth: Int = Constant.defaultPosterWidth
    
    init(delegate: MoviesCollectionPresenterDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.name, for: indexPath) as! MovieCollectionViewCell
        let urlStr = delegate.movies[indexPath.row].posterPath(withWidth: moviePosterWidth)
        
        ImageManager.getImage(url: urlStr) {
            cell.posterImageView.image = $0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = delegate.movies[indexPath.row]
        let movieVc = MovieViewController(movie: movie)
        delegate.navigationController?.pushViewController(movieVc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > delegate.movies.count - 2 {
            delegate.fetchMovies()
        }
    }
    
}

