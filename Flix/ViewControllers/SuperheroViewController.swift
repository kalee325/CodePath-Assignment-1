//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Ka Lee on 9/6/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SuperheroViewController.didPullToRefresh(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        
        superheroFetch()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        
        superheroFetch()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        cell.movie = movies[indexPath.item]
        /*
        let movie = movies[indexPath.item]
        if let posterPathSrting = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathSrting)!
            cell.posterImageView.af_setImage(withURL: posterURL)

        }
        */
        return cell
    }
    
    func superheroFetch(){
        MovieApiManager().superHeroMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    /*
    func fectchMovies(){
        //activityIndicator.startAnimating()
        let url = URL(string: "https://api.themoviedb.org/3/movie/363088/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //This will run when the network request returns
            if let error = error {
                //self.displayAlert()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.collectionView.reloadData()
                //self.refreshControl.endRefreshing()
                //self.activityIndicator.stopAnimating()
                
            }
        }
        task.resume()
    }
    */
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
