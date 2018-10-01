//
//  PosterCell.swift
//  Flix
//
//  Created by Ka Lee on 9/6/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            let posterPath = movie.posterUrl
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURLString = URL(string: baseURLString + posterPath)!
            
            posterImageView.af_setImage(withURL: posterURLString)
        }
    }
}
