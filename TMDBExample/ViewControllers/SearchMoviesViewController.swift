//
//  SearchMoviesViewController.swift
//  TMDBExample
//
//  Created by ss on 14/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class SearchMoviesViewController: MoviesCollectionViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        return searchBar
    }()
    
    fileprivate var query: String?
    fileprivate var lastQuery: String? = ""
    
    var searchFetcher: SearchFetcher {
        return moviesFetcher as! SearchFetcher
    }
    
    required init?(coder aDecoder: NSCoder) {
        let fetcher = SearchFetcher()
        super.init(coder: aDecoder)
        self.moviesFetcher = fetcher
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.collectionViewLayout = FlowLayouts.moviesCollectionLayout
        navigationItem.titleView = searchBar
    }
    
}

extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        query = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if query == lastQuery {
            return
        }
        
        movies = []
        collectionView?.reloadData()
        searchFetcher.query = query
        lastQuery = query
        fetchMovies()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
