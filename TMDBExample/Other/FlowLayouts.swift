//
//  FlowLayouts.swift
//  TMDBExample
//
//  Created by ss on 14/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

struct FlowLayouts {
    
    static var moviesCollectionLayout: UICollectionViewFlowLayout {
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
        return layout
    }
    
    static var similarMoviesLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let smallPosterWidth = CGFloat(Constant.smallPosterWidth)
        layout.itemSize = CGSize(width: smallPosterWidth, height: smallPosterWidth * 1.5)
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
