//
//  CustomTableViewController.swift
//  TMDBExample
//
//  Created by ss on 13/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
}
