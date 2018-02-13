//
//  DiscoverTableViewController.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class DiscoverTableViewController: CustomTableViewController {
    
    private let categories = ["Popular", "Coming soon"]

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moviesVc = MoviesCollectionViewController(moviesFetcher: PopularMoviesFetcher())
        moviesVc.title = categories[indexPath.row]
        navigationController?.pushViewController(moviesVc, animated: true)
    }
    
}
