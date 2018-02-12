//
//  GenresTableViewController.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class GenresTableViewController: UITableViewController {
    
    private var genres: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        API.getGenres(success: { genres in
            self.tableView.beginUpdates()
            let indexPaths = (self.genres.count..<genres.count).map { IndexPath(row: $0, section: 0) }
            self.genres += genres
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
            
        }, failure: { error in
            print("👹👹👹👹👹👹👹")
        })
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
    
}
