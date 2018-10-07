//
//  DetailViewController.swift
//  Flix
//
//  Created by Danny on 9/14/18.
//  Copyright © 2018 Danny Rivera. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var averageVoteLabel: UILabel!
    
    var movies: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = movies.title
        self.releaseDateLabel.text = movies.releaseDate
        self.overviewLabel.text = movies.overview
        self.averageVoteLabel.text = ""
        self.backDropImageView.af_setImage(withURL: movies.backDropUrl!)
        self.posterImageView.af_setImage(withURL: movies.posterUrl!)
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
