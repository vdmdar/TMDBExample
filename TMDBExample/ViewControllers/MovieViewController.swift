//
//  MovieViewController.swift
//  TMDBExample
//
//  Created by ss on 12/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class MovieViewController: UITableViewController {
    
    enum Section: String {
        case backdrop
        case details = "Overview"
        case cast = "Cast"
        case similar = "Similar movies"
    }
    
    var movie: Movie? = nil
    
    var sections: [Section] = [.backdrop, .details]
    
    var cast: [Cast] = []
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        title = movie?.title
        tableView.register(MovieDetailsTableViewCell.nib, forCellReuseIdentifier: MovieDetailsTableViewCell.name)
        tableView.register(MovieBackdropTableViewCell.nib, forCellReuseIdentifier: MovieBackdropTableViewCell.name)
        tableView.register(MovieCastTableViewCell.nib, forCellReuseIdentifier: MovieCastTableViewCell.name)
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.separatorStyle = .none
        getCast()

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
        default:
            return UITableViewCell()
        }
        
    }
    
    func getDetailsCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.name, for: indexPath) as! MovieDetailsTableViewCell
        cell.overviewTextView.text = movie?.overview
        return cell
    }
    
    func getBackdropCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieBackdropTableViewCell.name, for: indexPath) as! MovieBackdropTableViewCell
        let imagePath = movie!.backdropPath(withWidth: 1280)
        ImageManager.getImage(url: imagePath, completion: {
            cell.backdropImageView.image = $0
        })
        return cell
    }
    
    func getCastCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCastTableViewCell.name, for: indexPath) as! MovieCastTableViewCell
        let actor = cast[indexPath.row]
        cell.castNameLabel.text = actor.name
        cell.castCharacterLabel.text = actor.character
        let imagePath = actor.profileImagePath(imageWidth: 185)
        ImageManager.getImage(url: imagePath, completion: {
            cell.castImageView.image = $0
        })
        
        return cell
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
    
    func getCast() {
        let id = movie?.id
        
        API.getCast(movieId: id!, success: {
            guard !$0.isEmpty else { return }
            self.cast = $0
            
            self.sections.append(.cast)
            self.tableView.beginUpdates()
            self.tableView.insertSections([self.sections.index(of: .cast) ?? 2], with: .automatic)
            self.tableView.endUpdates()
            
        }, failure: {
            print($0)
        })
    }
    
}
