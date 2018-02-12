//
//  MovieCastTableViewCell.swift
//  TMDBExample
//
//  Created by ss on 12/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

final class MovieCastTableViewCell: UITableViewCell, NibGettable {
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castCharacterLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        castImageView.layer.cornerRadius = castImageView.frame.height / 2
        castImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        castImageView.image = nil
        castNameLabel.text = nil
        castCharacterLabel.text = nil
    }
}
