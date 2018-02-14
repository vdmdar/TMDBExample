//
//  MovieViewController.swift
//  TMDBExample
//
//  Created by ss on 12/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class MovieViewController: CustomTableViewController, MoviesCollectionPresenterDelegate {
    
    fileprivate enum Section: String {
        case backdrop
        case details = "Overview"
        case cast = "Cast"
        case similar = "Similar movies"
    }
    
    fileprivate let movie: Movie
    fileprivate var sections: [Section] = [.backdrop, .details]
    fileprivate var cast: [Cast] = []
    fileprivate var similarMovies: [Movie] = []
    
    var movies: [Movie] {
        return similarMovies
    }
    
    private lazy var moviesPresenter: MoviesCollectionPresenter = {
        let presenter = MoviesCollectionPresenter(delegate: self)
        presenter.moviePosterWidth = Constant.smallPosterWidth
        return presenter
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        setupTableView()
        getCast()
        getSimilar()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = sections[section]
        if sec == .cast {
            return cast.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .backdrop:
            return getBackdropCell(from: tableView, indexPath: indexPath)
        case .details:
            return getDetailsCell(from: tableView, indexPath: indexPath)
        case .cast:
            return getCastCell(from: tableView, indexPath: indexPath)
        case .similar:
            return getSimilarMoviesCell(from: tableView, indexPath: indexPath)
        }
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = sections[section]
        
        if sec == .backdrop {
            return nil
        }
        
        return sec.rawValue
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sec = sections[section]
        if sec == .backdrop {
            return 0
        }
        
        return 32
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(MovieDetailsTableViewCell.nib, forCellReuseIdentifier: MovieDetailsTableViewCell.name)
        tableView.register(MovieBackdropTableViewCell.nib, forCellReuseIdentifier: MovieBackdropTableViewCell.name)
        tableView.register(MovieCastTableViewCell.nib, forCellReuseIdentifier: MovieCastTableViewCell.name)
        tableView.register(SimilarMoviesTableViewCell.nib, forCellReuseIdentifier: SimilarMoviesTableViewCell.name)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }

}

extension MovieViewController {
    
    fileprivate func getDetailsCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.name, for: indexPath) as! MovieDetailsTableViewCell
        cell.overviewTextView.text = movie.overview
        return cell
    }
    
    fileprivate func getBackdropCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieBackdropTableViewCell.name, for: indexPath) as! MovieBackdropTableViewCell
        let imagePath = movie.backdropPath(withWidth: Constant.defaultBackdropWidth)
        ImageManager.getImage(url: imagePath, completion: {
            cell.backdropImageView.image = $0
        })
        return cell
    }
    
    fileprivate func getCastCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastTableViewCell.name, for: indexPath) as! MovieCastTableViewCell
        let actor = cast[indexPath.row]
        cell.castNameLabel.text = actor.name
        cell.castCharacterLabel.text = actor.character
        let imagePath = actor.profileImagePath(imageWidth: Constant.defaultProfileWidth)
        ImageManager.getImage(url: imagePath, completion: {
            cell.castImageView.image = $0
        })
        
        return cell
    }
    
    fileprivate func getSimilarMoviesCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMoviesTableViewCell.name, for: indexPath) as! SimilarMoviesTableViewCell
        cell.collectionView.dataSource = moviesPresenter
        cell.collectionView.delegate = moviesPresenter
        return cell
    }
    
}

extension MovieViewController {
    fileprivate func getCast() {
        API.getCast(movieId: movie.id, success: {
            guard !$0.isEmpty else { return }
            let moreThanTen = $0.count > 10
            
            if moreThanTen {
                let firstTen = ($0.sorted { $0.order < $1.order})
                self.cast = Array(firstTen[0..<10])
            } else {
                self.cast = $0
            }
            
            self.sections.insert(.cast, at: 2)
            self.tableView.beginUpdates()
            self.tableView.insertSections([self.sections.index(of: .cast)!], with: .automatic)
            self.tableView.endUpdates()
            
        }, failure: {
            print($0)
        })
    }
    
    fileprivate func getSimilar() {
        API.getSimilar(movieId: movie.id, page: 1, success: {
            guard !$0.isEmpty else { return }
            self.similarMovies = $0
            if let indexOfCast = self.sections.index(of: .cast) {
                self.sections.insert(.similar, at: indexOfCast + 1)
            } else {
                self.sections.append(.similar)
            }
            self.tableView.beginUpdates()
            self.tableView.insertSections([self.sections.index(of: .similar)!], with: .automatic)
            self.tableView.endUpdates()
        }, failure: {
            print($0)
        })
    }
    
}


