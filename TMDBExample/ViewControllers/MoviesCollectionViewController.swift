//
//  MoviesCollectionViewController.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

class MoviesCollectionViewController: UICollectionViewController, MoviesCollectionPresenterDelegate {
    
    var moviesFetcher: Fetcher<Movie>!
    var movies: [Movie] = []
    
    lazy var moviesPresenter: MoviesCollectionPresenter = {
        return MoviesCollectionPresenter(delegate: self)
    }()
    
    init(moviesFetcher: Fetcher<Movie>) {
        self.moviesFetcher = moviesFetcher
        super.init(collectionViewLayout: FlowLayouts.moviesCollectionLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.name)
        collectionView?.backgroundColor = .white
        collectionView?.keyboardDismissMode = .onDrag
        collectionView?.delegate = moviesPresenter
        collectionView?.dataSource = moviesPresenter
        fetchMovies()
    }
    
    func fetchMovies() {
        moviesFetcher.fetch { [weak self] movies in
            self?.movies += movies
            self?.collectionView?.reloadData()
        }
    }

}
