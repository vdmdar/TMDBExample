//
//  MoviesCollectionViewController.swift
//  TMDBExample
//
//  Created by ss on 10/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class MoviesCollectionViewController: UICollectionViewController {
    
    var movies: [Movie] = []
    
    init(title: String?) {
        
        let screenW = UIScreen.main.bounds.width
        
        let divisor: CGFloat = 4
        
        let width = (screenW / divisor) * 1.2
        let height = width * 1.5
        
        let spacing: CGFloat = (screenW / divisor) * 0.2 / 4
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        super.init(collectionViewLayout: layout)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: MovieCollectionViewCell.name, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.name)
        
        collectionView?.backgroundColor = .white
        
        API.getUpcoming(page: 1, success: {
            self.movies = $0
            self.collectionView?.reloadData()
        }, failure: { _ in
            print("👹👹👹👹👹👹👹")
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.name, for: indexPath) as! MovieCollectionViewCell
        let urlStr = movies[indexPath.row].posterPath
        
        ImageManager.getImage(url: urlStr) {
            cell.posterImageView.image = $0
        }
        
        return cell
    }
    
}
