//
//  MovieCell.swift
//  Flix
//
//  Created by Ka Lee on 9/5/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterimageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            let title = movie.title
            let overview = movie.overview
            let posterPath = movie.posterUrl
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURLString = URL(string: baseURLString + posterPath)!
            
            titleLabel.text = title
            overviewLabel.text = overview
            posterimageView.af_setImage(withURL: posterURLString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
