//
//  DetailViewController.swift
//  Flix
//
//  Created by Danny on 9/14/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let releaseDate = "release_date"
    static let overview = "overview"
    static let voteAverage = "vote_average"
    static let backDropPath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var averageVoteLabel: UILabel!
    
    var movies: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movies {
            self.titleLabel.text = movie[MovieKeys.title] as? String
            self.releaseDateLabel.text = (movie[MovieKeys.releaseDate] as? String)
            self.overviewLabel.text = movie[MovieKeys.overview] as? String
            self.averageVoteLabel.text = movie[MovieKeys.voteAverage] as? String
            let backDropPathString = movie[MovieKeys.backDropPath] as! String
            let posterPathString = movie[MovieKeys.posterPath] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let backDropURL = URL(string: baseURLString + backDropPathString)!
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            self.backDropImageView.af_setImage(withURL: backDropURL)
            self.posterImageView.af_setImage(withURL: posterPathURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
