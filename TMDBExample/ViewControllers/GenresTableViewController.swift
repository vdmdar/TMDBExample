//
//  GenresTableViewController.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class GenresTableViewController: CustomTableViewController {
    
    private var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGenres()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = genres[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = genres[indexPath.row]
        let fetcher = ByGenreMoviesFetcher(genreId: genre.id)
        let moviesVc = MoviesCollectionViewController(moviesFetcher: fetcher)
        moviesVc.title = genre.name
        navigationController?.pushViewController(moviesVc, animated: true)
    }
    
    private func getGenres() {
        API.getGenres(success: { genres in
            self.tableView.beginUpdates()
            let indexPaths = (self.genres.count..<genres.count).map { IndexPath(row: $0, section: 0) }
            self.genres += genres
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
            
        }, failure: {
            print($0)
        })
    }
    
}
