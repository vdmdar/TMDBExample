//
//  SimilarMoviesTableViewCell.swift
//  TMDBExample
//
//  Created by ss on 13/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class SimilarMoviesTableViewCell: UITableViewCell, NibGettable {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.name)
            let layout = FlowLayouts.similarMoviesLayout
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
        }
    }
    
}
